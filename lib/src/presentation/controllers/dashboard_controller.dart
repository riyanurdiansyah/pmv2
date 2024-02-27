import 'dart:async';
import 'dart:convert';

import 'package:business_logic/business_logic.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/utils/config/app_dependency_injection.dart';
import 'package:pman/src/utils/config/app_route_name.dart';
import 'package:pman/src/utils/config/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/approval.dart';
import '../../entities/mytask.dart';
import '../../entities/user.dart';

class DashboardController extends GetxController {
  final SessionRepository sessionRepository = getIt<SessionRepository>();
  final myTaskRepository = getIt<MyTaskRepository>();
  final approvalRepository = getIt<ApprovalRepository>();

  final Rx<UserEntity> user = UserEntity.emptyObject().obs;

  late SharedPreferences prefs;

  late Timer _timer;
  final Rx<int> countTasks = 0.obs;
  final Rx<int> countApprovals = 0.obs;
  @override
  void onInit() {
    setup();
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  Future setup() async {
    prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString("user");
    final userRole = prefs.getString("role");
    if (userString != null && userRole != null) {
      user.value = UserEntity.fromJson(json.decode(userString));

      getPeriodicMyTaskCount();
    }
  }

  Future checkVersion() async {
    sessionRepository.checkVersion().then((response) {
      if (response != null && response.isNotEmpty) {
        navigatorKey.currentContext!.goNamed(AppRouteName.version, extra: {
          "link": response,
        });
      }
    });
  }

  Future getTasks() async {
    final body = {
      "pageKey": 1,
      "dataPerPage": 1000,
      "employeeNIK": user.value.objData.txtEmployeeId,
      "filterKey": "",
      "filterValue": "",
      "isSuperUser": false,
    };

    final response = await myTaskRepository.getTasks(request: body);
    response.fold(
      (fail) {},
      (data) async {
        final list = myTaskObjDatas(json.encode(data["objData"]));
        countTasks.value = list.length;
      },
    );
  }

  Future getApprovalTaskByLead() async {
    final response = await approvalRepository
        .getApprovalTaskByLead(user.value.objData.txtEmployeeId);
    response.fold(
      (fail) {},
      (data) async {
        final list = approvalObjDatas(json.encode(data["objData"]));
        countApprovals.value = list
            .where((e) => e.txtResourceCode != user.value.objData.txtEmployeeId)
            .toList()
            .length;
      },
    );
  }

  void getPeriodicMyTaskCount() async {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      getTasks();
      getApprovalTaskByLead();
      checkVersion();
    });
  }
}
