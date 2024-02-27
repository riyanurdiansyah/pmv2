import 'dart:convert';

import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/entities/mytask.dart';
import 'package:pman/src/entities/task_status.dart';
import 'package:pman/src/utils/config/app_dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user.dart';
import '../../utils/common/app_bottom_dialog.dart';
import '../../utils/common/app_common.dart';
import '../../utils/config/app_router.dart';

enum StatusType { hold, cancel, non }

class MyTaskController extends GetxController {
  late SharedPreferences prefs;

  final formKey = GlobalKey<FormState>();
  MyTaskRepository myTaskRepository = getIt<MyTaskRepository>();

  final Rx<int> page = 1.obs;

  final Rx<bool> isViewTable = false.obs;

  final Rx<RangeValues> percentFilter = const RangeValues(0, 100).obs;

  final Rx<RangeLabels> percentLabelFilter =
      const RangeLabels("0%", "100%").obs;

  final Rx<UserEntity> user = UserEntity.emptyObject().obs;

  final RxList<MyTaskObjData> mytasks = <MyTaskObjData>[].obs;
  final RxList<MyTaskObjData> mytasksSearch = <MyTaskObjData>[].obs;

  final RxList<String> resources = <String>[].obs;
  final RxList<String> resourcesFilter = <String>[].obs;

  final RxList<String> progress = <String>[].obs;

  final RxList<String> statuss = <String>[].obs;
  final RxList<String> statussFilter = <String>[].obs;

  final Rx<bool> isSearch = false.obs;
  final Rx<bool> isFilter = false.obs;
  final Rx<bool> isLoading = true.obs;
  final Rx<bool> isLoadingSubmit = false.obs;

  final Rx<MyTaskObjData> taskSelected = mytaskObjEmpty.obs;

  final Rx<TaskStatusEntity> taskStatus = taskStatusEmpty.obs;

  final tcSearch = TextEditingController();

  final tcNote = TextEditingController();

  final RxList<StatusType> statusTypes = <StatusType>[].obs;
  final Rx<StatusType> selectedStatusType = StatusType.non.obs;

  // final Rx<String> statusNext = "".obs;

  final Rx<TaskStatusObjData> taskStatusSelected = taskStatusObjDataEmpty.obs;

  final Rx<String> errorMessage = "".obs;

  final Rx<LtRole> selectedRole = LtRole.emptyObject().obs;

  void onChangePage(int newValue) {
    page.value = newValue;
  }

  void onChangeView() {
    isViewTable.value = !isViewTable.value;
  }

  @override
  void onInit() async {
    await setup();
    await changeLoading(false);
    super.onInit();
  }

  Future changeLoading(bool newValue) async {
    isLoading.value = newValue;
  }

  Future setup() async {
    prefs = await SharedPreferences.getInstance();
    statusTypes.value = StatusType.values;
    final roleString = prefs.getString("role");
    final userString = prefs.getString("user");
    if (userString != null && roleString != null) {
      user.value = UserEntity.fromJson(json.decode(userString));
      selectedRole.value = LtRole.fromJson(json.decode(roleString));
      await getTasks();
    }
  }

  Future getTasks() async {
    final body = {
      "pageKey": 1,
      "dataPerPage": 100,
      "employeeNIK": user.value.objData.txtEmployeeId,
      "filterKey": "",
      "filterValue": "",
      "isSuperUser": selectedRole.value.bitSuperuser,
    };

    final response = await myTaskRepository.getTasks(request: body);
    clearFilter();
    response.fold(
      (fail) {
        errorMessage.value = fail;
      },
      (data) async {
        mytasks.value = myTaskObjDatas(json.encode(data["objData"]));
        mytasks.sort((b, a) => DateTime.parse(b.dtmPlanEndDate)
            .compareTo(DateTime.parse(a.dtmPlanEndDate)));
        addPaginationToTasks();
        createDynamicFilter();
        if (tcSearch.text.isNotEmpty) {
          onSearchTask(tcSearch.text);
        }
      },
    );
  }

  Future<List<TaskStatusObjData>> getTaskStatus() async {
    final request = {
      "txtUserName": user.value.objData.txtUserName,
      "mdl": "TASK_STATUS",
      "fnc": "txtStatusUpdate",
      "query":
          "${taskSelected.value.txtDeptCode}|${taskSelected.value.txtMilestone}|${taskSelected.value.txtStatus}|${taskSelected.value.intProjectTaskId}"
    };
    final response = await myTaskRepository.getTaskStatus(request: request);
    taskStatus.value = TaskStatusEntity.fromJson(response);
    return taskStatus.value.objData;
  }

  void createDynamicFilter() {
    statuss.value = mytasks.map((e) => e.txtStatus).toSet().toList();
    statussFilter.value = mytasks.map((e) => e.txtStatus).toSet().toList();
    resources.value = mytasks.map((e) => e.txtResourceName).toSet().toList();
    resourcesFilter.value =
        mytasks.map((e) => e.txtResourceName).toSet().toList();
  }

  void addPaginationToTasks() {
    double pageTemp = 0;
    for (int i = 0; i < mytasks.length; i++) {
      pageTemp = (i + 1) ~/ 4 < 1 ? 1 : (i + 1) / 4;
      mytasks[i] = mytasks[i].copyWith(page: pageTemp.ceil());
    }
    mytasks.sort((a, b) => b.dtmPlanStartDate.compareTo(a.dtmPlanStartDate));
  }

  void onSearchTask(String query) {
    clearFilter();
    page.value = 1;
    double pageTemp = 0;
    List<MyTaskObjData> taskTemp = [];
    if (query.isEmpty) {
      isSearch.value = false;
      taskTemp.clear();
      mytasksSearch.clear();
    } else {
      isSearch.value = true;
      taskTemp = mytasks
          .where((e) =>
              e.txtDeptCode.toLowerCase().contains(query.toLowerCase()) ||
              e.txtResourceCode.toLowerCase().contains(query.toLowerCase()) ||
              e.txtProjectObjectiveDesc
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              e.txtDocReference.toLowerCase().contains(query.toLowerCase()) ||
              e.txtTaskDescription
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              e.txtProjectCode.toLowerCase().contains(query.toLowerCase()) ||
              e.txtDocReference.toLowerCase().contains(query.toLowerCase()) ||
              e.txtProjectLeader.toLowerCase().contains(query.toLowerCase()) ||
              e.txtProjectName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      for (int i = 0; i < taskTemp.length; i++) {
        pageTemp = (i + 1) ~/ 4 < 1 ? 1 : (i + 1) / 4;
        taskTemp[i] = taskTemp[i].copyWith(page: pageTemp.ceil());
      }
      mytasksSearch.value = taskTemp;
      mytasksSearch
          .sort((a, b) => b.dtmPlanStartDate.compareTo(a.dtmPlanStartDate));
    }
  }

  void changeFilterStatus(String status) {
    if (statussFilter.contains(status)) {
      statussFilter.remove(status);
    } else {
      statussFilter.add(status);
    }
  }

  void changeFilterResource(String resource) {
    if (resourcesFilter.contains(resource)) {
      resourcesFilter.remove(resource);
    } else {
      resourcesFilter.add(resource);
    }
  }

  void applyFilter() {
    page.value = 1;
    double pageTemp = 0;
    List<MyTaskObjData> taskTemp = [];
    taskTemp = mytasks
        .where((e) =>
            statussFilter.contains(e.txtStatus) &&
            resourcesFilter.contains(e.txtResourceName) &&
            e.intProgressValue >= percentFilter.value.start.toInt() &&
            e.intProgressValue <= percentFilter.value.end.toInt())
        .toList();
    for (int i = 0; i < taskTemp.length; i++) {
      pageTemp = (i + 1) ~/ 4 < 1 ? 1 : (i + 1) / 4;
      taskTemp[i] = taskTemp[i].copyWith(page: pageTemp.ceil());
    }
    mytasksSearch.value = taskTemp;
    mytasksSearch
        .sort((a, b) => b.dtmPlanStartDate.compareTo(a.dtmPlanStartDate));
    resourcesFilter.value =
        mytasksSearch.map((e) => e.txtResourceName).toSet().toList();
    statussFilter.value =
        mytasksSearch.map((e) => e.txtStatus).toSet().toList();
    isFilter.value = true;

    navigatorKey.currentContext!.pop();
  }

  void clearFilter() {
    page.value = 1;
    mytasksSearch.clear();

    isFilter.value = false;

    statussFilter.value = List.from(statuss);
    resourcesFilter.value = List.from(resources);

    percentFilter.value = const RangeValues(0, 100);
  }

  void onCheckStatus(StatusType newValue) {
    if (newValue == selectedStatusType.value) {
      selectedStatusType.value = StatusType.non;
      taskStatusSelected.value = taskStatusObjDataEmpty;
    } else {
      selectedStatusType.value = newValue;
      taskStatusSelected.value = TaskStatusObjData(
        id: 0,
        name: newValue.name.toUpperCase(),
        progress: 0.0,
        finalFlag: false,
      );
    }
  }

  Future updateTask() async {
    if (formKey.currentState!.validate()) {
      isLoadingSubmit.value = true;
      navigatorKey.currentContext!.pop();
      final request = {
        "txtUserName": user.value.objData.txtUserName,
        "txtProjectTaskID": taskSelected.value.intProjectTaskId,
        "txtResourceCode": taskSelected.value.txtResourceCode,
        "txtMilestone": taskSelected.value.txtMilestone,
        "txtNextStatus": taskStatusSelected.value.name,
        "txtNote": tcNote.text,
        "txtFinalFlag": taskStatusSelected.value.finalFlag,
        "txtHoldTask": selectedStatusType.value == StatusType.hold,
        "txtCancelTask": selectedStatusType.value == StatusType.cancel,
        "txtGUID": taskStatus.value.txtGuid,
      };

      final response = await myTaskRepository.updateTask(request: request);
      clearDetailTask();
      isLoadingSubmit.value = false;
      response.fold(
        (fail) {
          Fluttertoast.showToast(msg: fail);
        },
        (data) {
          if (!data["bitSuccess"]) {
            Fluttertoast.showToast(msg: data["txtMessage"]);
          } else {
            getTasks();
            Fluttertoast.showToast(msg: "Data updated...!");
          }
        },
      );
    }
  }

  void clearDetailTask() {
    tcNote.clear();
    taskStatusSelected.value = taskStatusObjDataEmpty;
    selectedStatusType.value = StatusType.non;
  }

  void onTapTask(MyTaskObjData mytask) {
    taskSelected.value = mytask;
    AppBottomDialog.detailTask();
  }
}
