import 'dart:async';
import 'dart:convert';

import 'package:business_logic/business_logic.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pman/src/entities/initial_project.dart';
import 'package:pman/src/entities/log_task_status.dart';
import 'package:pman/src/entities/user.dart';
import 'package:pman/src/features/carousel/app_carousel_option.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/history.dart';
import '../../entities/menus.dart';
import '../../entities/mytask.dart';
import '../../utils/config/app_dependency_injection.dart';

class HomeController extends GetxController {
  late SharedPreferences prefs;
  MyTaskRepository myTaskRepository = getIt<MyTaskRepository>();

  final authRepository = getIt<AuthRepository>();
  NotifRepository notifRepository = getIt<NotifRepository>();
  ExecutionRepository executionRepository = getIt<ExecutionRepository>();

  final RxList<MyTaskObjData> mytasks = <MyTaskObjData>[].obs;

  final Rx<int> indexInitial = 0.obs;

  final Rx<int> dateBefore = 0.obs;

  final Rx<LtRole> selectedRole = LtRole.emptyObject().obs;

  final Rx<UserEntity> user = UserEntity.emptyObject().obs;

  final RxList<MenuEntity> menus = <MenuEntity>[].obs;

  final Rx<String> errorMessage = "".obs;

  final Rx<bool> isLoading = false.obs;

  final Rx<bool> isLoadingLog = true.obs;

  final Rx<bool> isLoadingInitial = true.obs;

  final RxList<HistoryEntity> histories = <HistoryEntity>[].obs;

  final Rx<InitialProjectEntity> initials =
      InitialProjectEntity.emptyObject().obs;

  final Rx<LogTaskStatusEntity> logTaskStatus =
      LogTaskStatusEntity.emptyObject().obs;

  final RxList<LogTaskStatusObjData> logTask2DBefore =
      <LogTaskStatusObjData>[].obs;

  final RxList<LogTaskStatusObjData> logTaskYesterday =
      <LogTaskStatusObjData>[].obs;

  final RxList<LogTaskStatusObjData> logTaskToday =
      <LogTaskStatusObjData>[].obs;

  late Timer _timer;

  @override
  void onInit() async {
    await setup();
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  Future getLogTaskStatus() async {
    logTaskStatus.value = LogTaskStatusEntity.emptyObject();
    final body = {
      "txtResourceCode": user.value.objData.txtEmployeeId,
      "intDateRange": 3
    };
    final response = await executionRepository.getLogTaskStatus(body: body);
    response.fold((fail) {
      logTaskStatus.value = logTaskStatus.value.copyWith(
        txtStackTrace: fail,
      );
      isLoadingLog.value = false;
    }, (data) {
      logTaskStatus.value = LogTaskStatusEntity.fromJson(data);
      filterLogTaskStatus();
      isLoadingLog.value = false;
    });
  }

  void filterLogTaskStatus() {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    DateTime dayBeforeYesterday = now.subtract(const Duration(days: 2));

    String formattedNow = DateFormat("yyyy-MM-dd").format(now);
    String formattedYesterday = DateFormat("yyyy-MM-dd").format(yesterday);
    String formattedDayBeforeYesterday =
        DateFormat("yyyy-MM-dd").format(dayBeforeYesterday);

    logTask2DBefore.value = List.from(logTaskStatus.value.objData
        .where((e) =>
            DateFormat("yyyy-MM-dd").format(e.dtmInsertedDate) ==
            formattedDayBeforeYesterday)
        .toList());

    logTaskYesterday.value = logTaskStatus.value.objData
        .where((e) =>
            DateFormat("yyyy-MM-dd").format(e.dtmInsertedDate) ==
            formattedYesterday)
        .toList();

    logTaskToday.value = logTaskStatus.value.objData
        .where((e) =>
            DateFormat("yyyy-MM-dd").format(e.dtmInsertedDate) == formattedNow)
        .toList();

    logTask2DBefore
        .sort((a, b) => b.dtmInsertedDate.compareTo(a.dtmInsertedDate));
    logTaskYesterday
        .sort((a, b) => b.dtmInsertedDate.compareTo(a.dtmInsertedDate));
    logTaskToday.sort((a, b) => b.dtmInsertedDate.compareTo(a.dtmInsertedDate));
  }

  Future getInitialProject() async {
    initials.value = InitialProjectEntity.emptyObject();
    final body = {
      "txtUserID": user.value.objData.intUserId.toString(),
      "txtStatus": "PLANNING",
      "bitSuperUser": selectedRole.value.bitSuperuser,
    };
    final response = await executionRepository.getInitialProject(body: body);
    response.fold((fail) {
      initials.value = initials.value.copyWith(
        txtStackTrace: fail,
      );
      isLoadingInitial.value = false;
    }, (data) {
      initials.value = InitialProjectEntity.fromJson(data);
      isLoadingInitial.value = false;
    });
  }

  Future changeLoading(bool newValue) async {
    isLoading.value = newValue;
  }

  Future setup() async {
    prefs = await SharedPreferences.getInstance();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final userString = prefs.getString("user");
    final userRole = prefs.getString("role");
    if (userString != null && userRole != null) {
      user.value = UserEntity.fromJson(json.decode(userString));
      selectedRole.value = LtRole.fromJson(json.decode(userRole));
      getHistories();
      getInitialProject();
      getLogTaskStatus();
    }
  }

  Future getHistories() async {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {});
  }

  Future getMenus() async {
    final body = {
      "intRoleID": selectedRole.value.intRoleId,
      "txtUserName": user.value.objData.txtUserName,
    };

    final response = await authRepository.menus(request: body);
    response.fold((fail) => errorMessage.value = fail, (data) {
      menus.value = menuEntityFromJson(data["objData"]["objData"]);
    });
  }

  String getInitials(String fullname) {
    return notifRepository.getInitials(fullname);
  }

  void onSlideInitial(int index, CarouselPageChangedReason reason) {
    indexInitial.value = index;
  }

  void onTapTaskStatus(int dbefore) {
    dateBefore.value = dbefore;
  }
}
