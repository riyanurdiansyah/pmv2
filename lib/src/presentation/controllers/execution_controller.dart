import 'dart:convert';

import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pman/src/entities/execution_project.dart';
import 'package:pman/src/entities/mytask.dart';
import 'package:pman/src/utils/config/app_dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user.dart';

class ExecutionProjectController extends GetxController {
  late SharedPreferences prefs;

  final Rx<ExecutionProjectEntity> executionProject =
      ExecutionProjectEntity.emptyObject().obs;

  final RxList<ExecutionProjectObjData> executions =
      <ExecutionProjectObjData>[].obs;

  final RxList<ExecutionProjectObjData> executionsSearch =
      <ExecutionProjectObjData>[].obs;

  final Rx<UserEntity> user = UserEntity.emptyObject().obs;

  final Rx<LtRole> selectedRole = LtRole.emptyObject().obs;

  final ExecutionRepository executionRepository = getIt<ExecutionRepository>();

  final tcSearch = TextEditingController();
  final Rx<bool> isSearch = false.obs;

  @override
  void onInit() async {
    await setup();
    super.onInit();
  }

  Future setup() async {
    prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString("user");
    final userRole = prefs.getString("role");
    if (userString != null && userRole != null) {
      user.value = UserEntity.fromJson(json.decode(userString));
      selectedRole.value = LtRole.fromJson(json.decode(userRole));
    }
    getExecutionProject();
  }

  Future getExecutionProject() async {
    final body = {
      "txtUserID": user.value.objData.txtEmployeeId,
      "bitSuperUser": selectedRole.value.bitSuperuser,
      "txtStatus": "PLANNING",
    };
    final response = await executionRepository.getExecutionProject(body: body);
    response.fold((fail) {
      executionProject.value = executionProject.value.copyWith(
        txtStackTrace: fail,
      );
    }, (data) {
      executionProject.value = ExecutionProjectEntity.fromJson(data);
      executions.value = executionProject.value.objData;
      addPaginationToTasks();
    });
  }

  void addPaginationToTasks() {
    double pageTemp = 0;
    for (int i = 0; i < executions.length; i++) {
      pageTemp = (i + 1) ~/ 4 < 1 ? 1 : (i + 1) / 4;
      executions[i] = executions[i].copyWith(page: pageTemp.ceil());
    }
    executions.sort((a, b) => b.dtmPlanStartDate.compareTo(a.dtmPlanStartDate));
  }

  MyTaskObjData convertToMyTaskObjData(ExecutionProjectObjData data) =>
      MyTaskObjData(
        intProjectId: data.intProjectId,
        intProjectPlanId: data.intProjectPlanId,
        intProjectObjectiveId: 0,
        txtProjectCode: data.txtProjectCode,
        txtProjectName: data.txtProjectName,
        txtDeptCode: "",
        txtDocReference: data.txtDocReference,
        txtProjectObjectiveDesc: data.txtProjectObjective,
        txtProjectLeader: "",
        txtProjectLeaderName: "",
        intProjectTaskId: 0,
        txtResourceCode: data.txtResourceCode,
        txtResourceName: data.txtResourceName,
        txtTaskDescription: data.txtMilestone,
        txtMilestone: data.txtMilestone,
        dtmPlanStartDate: data.dtmPlanStartDate,
        dtmPlanEndDate: data.dtmPlanEndDate,
        txtStatus: data.txtProjectName,
        bitFinalProceed: false,
        bitHold: false,
        txtNextStatus: "",
        txtNote: "",
        intDueProgressValue: data.intProgressValue,
        intProgressValue: data.intProgressValue,
        txtProgressValue: data.txtProgressValue,
        page: data.page,
      );

  void onSearchTask(String query) {
    List<ExecutionProjectObjData> taskTemp = [];
    if (query.isEmpty) {
      isSearch.value = false;
      taskTemp.clear();
      executionsSearch.clear();
    } else {
      isSearch.value = true;
      taskTemp = executions
          .where((e) =>
              e.txtResourceCode.toLowerCase().contains(query.toLowerCase()) ||
              e.txtMilestone.toLowerCase().contains(query.toLowerCase()) ||
              e.txtDocReference.toLowerCase().contains(query.toLowerCase()) ||
              e.txtProjectCode.toLowerCase().contains(query.toLowerCase()) ||
              e.txtDocReference.toLowerCase().contains(query.toLowerCase()) ||
              e.txtProjectName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      executionsSearch.value = taskTemp;
      executionsSearch
          .sort((a, b) => b.dtmPlanStartDate.compareTo(a.dtmPlanStartDate));
    }
  }
}
