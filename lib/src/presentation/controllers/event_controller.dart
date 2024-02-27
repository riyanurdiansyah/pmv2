import 'dart:convert';

import 'package:business_logic/business_logic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pman/src/entities/project_task_date.dart';
import 'package:pman/src/entities/user.dart';
import 'package:pman/src/utils/config/app_dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventController extends GetxController {
  final Rx<DateTime> focusedDay = DateTime.now().obs;

  final Rx<DateTime> selectedDay = DateTime.now().obs;

  late SharedPreferences prefs;

  final Rx<UserEntity> user = UserEntity.emptyObject().obs;

  final MyTaskRepository myTaskRepository = getIt<MyTaskRepository>();

  final Rx<ProjectTaskDateEntity> projectTaskDate =
      ProjectTaskDateEntity.emptyObject().obs;

  final Rx<bool> isLoading = true.obs;

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString("user");
    if (userString != null) {
      user.value = UserEntity.fromJson(json.decode(userString));
      await getTaskDate();
      isLoading.value = false;
    }
    super.onInit();
  }

  Future getTaskDate() async {
    final body = {
      "txtResourceCode": user.value.objData.txtEmployeeId,
    };
    final response = await myTaskRepository.getTaskDate(request: body);
    response.fold((fail) {
      projectTaskDate.value = projectTaskDate.value.copyWith(
        txtStackTrace: fail,
      );
      Fluttertoast.showToast(msg: fail);
    }, (data) {
      projectTaskDate.value = ProjectTaskDateEntity.fromJson(data);
    });
  }

  void onChangeFocusedDay(DateTime date) {
    selectedDay.value = date;
    focusedDay.value = date;
  }

  void onChangeSelectedDay(DateTime sDay, DateTime fDay) {
    selectedDay.value = sDay;
    focusedDay.value = fDay;
  }

  bool onSelectedDayPredicate(DateTime day) {
    return selectedDay.value == day;
  }

  List<ProjectTaskDateObjData> getEvents(DateTime day) {
    final list = projectTaskDate.value.objData
        .where((e) {
          final start = DateTime.parse(e.start);
          final end = DateTime.parse(e.end);
          return start.isBefore(day) && end.isAfter(day);
        })
        .toSet()
        .toList();
    return list;
  }
}
