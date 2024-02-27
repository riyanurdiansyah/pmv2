import 'dart:convert';

import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pman/src/entities/approval.dart';
import 'package:pman/src/entities/approval_category.dart';
import 'package:pman/src/entities/dev_source.dart';
import 'package:pman/src/entities/project_leader.dart';
import 'package:pman/src/entities/task_effort_category.dart';
import 'package:pman/src/utils/common/app_bottom_dialog.dart';
import 'package:pman/src/utils/common/app_common.dart';
import 'package:pman/src/utils/config/app_dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user.dart';
import '../../utils/config/app_router.dart';

class ApproveController extends GetxController {
  late SharedPreferences prefs;

  final _approvalRepository = getIt<ApprovalRepository>();

  final Rx<int> page = 1.obs;

  final Rx<int> dataLength = 8.obs;

  final Rx<bool> isViewTable = false.obs;

  final Rx<bool> isLoading = true.obs;

  final Rx<bool> isSubLoading = false.obs;

  final Rx<bool> isApproveFailed = false.obs;

  final Rx<String> errorMessage = "".obs;

  // final Rx<ApprovalEntity> approval = approvalEmpty.obs;

  final Rx<ProjectLeaderObjData> selectedLeader = projectLeaderEmpty.obs;

  final Rx<DevSourceObjData> selectedDevSource = devSourceDataEmpty.obs;

  final Rx<ApprovalObjData> selectedApproval = approvalObjDataEmpty.obs;

  final RxList<int> selectedProjectIDs = <int>[].obs;

  final Rx<ApprovalCategoryObjData> seletedCategoryLOV =
      approvalCategoryLOVEmpty.obs;

  final RxList<ApprovalObjData> approvals = <ApprovalObjData>[].obs;
  final RxList<ApprovalObjData> approvalsSearch = <ApprovalObjData>[].obs;

  final Rx<bool> isSearch = false.obs;

  final tcSearch = TextEditingController();

  final tcLeadTime = TextEditingController();

  final RxList<TextEditingController> tcLeadTimeList =
      <TextEditingController>[].obs;

  final Rx<UserEntity> user = UserEntity.emptyObject().obs;

  final Rx<LtRole> selectedRole = LtRole.emptyObject().obs;

  @override
  void onInit() async {
    await setup();
    await changeLoading(false);
    super.onInit();
  }

  Future setup() async {
    prefs = await SharedPreferences.getInstance();
    final roleString = prefs.getString("role");
    final userString = prefs.getString("user");
    if (userString != null && roleString != null) {
      user.value = UserEntity.fromJson(json.decode(userString));
      selectedRole.value = LtRole.fromJson(json.decode(roleString));
    }
  }

  Future<List<DevSourceObjData>> getDevSourceByTeamName(String teamName) async {
    final response = await _approvalRepository.getDevSourceByTeamName(teamName);
    return response.map((e) => DevSourceObjData.fromJson(e)).toList();
  }

  Future<List<ApprovalCategoryObjData>> getAppCategoryLOV(String search) async {
    final response = await _approvalRepository.getListAppCategoryLOV(search);
    return response.map((e) => ApprovalCategoryObjData.fromJson(e)).toList();
  }

  void addPaginationToTasks() {
    double pageTemp = 0;
    for (int i = 0; i < approvals.length; i++) {
      pageTemp = (i + 1) ~/ 5 < 1 ? 1 : (i + 1) / 5;
      approvals[i] = approvals[i].copyWith(page: pageTemp.ceil());
    }
    approvals.sort((a, b) => b.dtmPlanStartDate.compareTo(a.dtmPlanStartDate));
  }

  void addListTextEditingLead(int lengList) {
    tcLeadTimeList.value =
        List.generate(lengList, (index) => TextEditingController());

    for (int i = 0; i < approvals.length; i++) {
      tcLeadTimeList[i].text = approvals[i].intLeadTime.toString();
    }
  }

  void onChangePage(int newValue) {
    page.value = newValue;
  }

  void onChangeView() {
    isViewTable.value = !isViewTable.value;
  }

  Future changeLoading(bool newValue) async {
    isLoading.value = newValue;
  }

  Future<List<ProjectLeaderObjData>> getLeaders() async {
    final body = {
      "userName": user.value.objData.txtFullName,
      "bitSuperUser": selectedRole.value.bitSuperuser,
    };

    final response = await _approvalRepository.getProjectLeader(body);
    return response.map((e) => ProjectLeaderObjData.fromJson(e)).toList();
  }

  Future getApprovalTaskByLead() async {
    final response = await _approvalRepository
        .getApprovalTaskByLead(selectedLeader.value.txtPicStreamNik);
    response.fold(
      (fail) {
        errorMessage.value = fail;
      },
      (data) async {
        approvals.value = approvalObjDatas(json.encode(data["objData"]));

        addListTextEditingLead(approvals.length);
        addPaginationToTasks();
      },
    );
  }

  Future getTaskEffortCategory() async {
    final data = TaskEffortCategoryObjRequest(
      intLeadtime: int.parse(tcLeadTime.text),
      txtDeptCode: selectedApproval.value.txtDeptCode,
      txtMilestone: selectedApproval.value.txtMilestone,
    );
    final response =
        await _approvalRepository.getTaskEffortCategory(data.toJson());
    response.fold(
      (fail) {
        errorMessage.value = fail;
      },
      (rawData) async {
        final taskEffort = TaskEffortCategoryEntity.fromJson(rawData);
        selectedApproval.value = selectedApproval.value.copyWith(
          intLeadTime: taskEffort.objData.intLeadtime,
          txtCategoryType: taskEffort.objData.txtTaskEffortCategory,
          txtDeptCode: taskEffort.objData.txtDeptCode,
        );
      },
    );
  }

  Future getTaskEffortCategoryTable(int index) async {
    final data = TaskEffortCategoryObjRequest(
      intLeadtime: int.parse(tcLeadTimeList[index].text),
      txtDeptCode: approvals[index].txtDeptCode,
      txtMilestone: approvals[index].txtMilestone,
    );
    final response =
        await _approvalRepository.getTaskEffortCategory(data.toJson());
    response.fold(
      (fail) {
        errorMessage.value = fail;
      },
      (rawData) async {
        final taskEffort = TaskEffortCategoryEntity.fromJson(rawData);
        approvals[index] = approvals[index].copyWith(
          intLeadTime: taskEffort.objData.intLeadtime,
          txtCategoryType: taskEffort.objData.txtTaskEffortCategory,
          txtDeptCode: taskEffort.objData.txtDeptCode,
        );
      },
    );
  }

  Future onChangeLead(ProjectLeaderObjData? newValue) async {
    if (newValue != null) {
      selectedProjectIDs.clear();
      selectedLeader.value = newValue;
      await changeLoading(true);
      await getApprovalTaskByLead();
      await changeLoading(false);
    }
  }

  void selectCardApproval(ApprovalObjData newData) {
    selectedApproval.value = newData;
    tcLeadTime.text = newData.intLeadTime.toString();
    AppBottomDialog.detailApproval();
  }

  void onSearchApproval(String query) {
    page.value = 1;
    double pageTemp = 0;
    List<ApprovalObjData> taskTemp = [];
    if (query.isEmpty) {
      isSearch.value = false;
      taskTemp.clear();
      approvalsSearch.clear();
    } else {
      isSearch.value = true;
      taskTemp = approvals
          .where((e) =>
              e.txtDeptCode.toLowerCase().contains(query.toLowerCase()) ||
              e.txtResourceCode.toLowerCase().contains(query.toLowerCase()) ||
              e.txtProjectObjectiveDesc
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              e.txtTaskDescription
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              e.txtProjectName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      for (int i = 0; i < taskTemp.length; i++) {
        pageTemp = (i + 1) ~/ 5 < 1 ? 1 : (i + 1) / 5;
        taskTemp[i] = taskTemp[i].copyWith(page: pageTemp.ceil());
      }
      approvalsSearch.value = taskTemp;
      approvalsSearch
          .sort((a, b) => b.dtmPlanStartDate.compareTo(a.dtmPlanStartDate));
    }
  }

  void onChangeDev(DevSourceObjData? newValue) {
    if (newValue != null) {
      selectedDevSource.value = newValue;
      selectedApproval.value = selectedApproval.value.copyWith(
        txtResourceName: newValue.txtResourceName,
        txtResourceCode: newValue.txtNik,
        txtDeptCode: newValue.txtDepartmentCode,
      );
    }
  }

  void onChangeDevTable(DevSourceObjData? newValue, int index) {
    if (newValue != null) {
      approvals[index] = approvals[index].copyWith(
        txtResourceName: newValue.txtResourceName,
        txtResourceCode: newValue.txtNik,
        txtDeptCode: newValue.txtDepartmentCode,
      );
    }
  }

  void onChangeCategoryLOV(ApprovalCategoryObjData? newValue) {
    if (newValue != null) {
      seletedCategoryLOV.value = newValue;
      selectedApproval.value = selectedApproval.value.copyWith(
        txtCategory: newValue.txtDescription,
        intLeadTime: 0,
      );
      tcLeadTime.text = "0";
    }
  }

  void onChangeCategoryLOVTable(ApprovalCategoryObjData? newValue, int index) {
    if (newValue != null) {
      seletedCategoryLOV.value = newValue;
      approvals[index] = approvals[index].copyWith(
        txtCategory: newValue.txtDescription,
        intLeadTime: 0,
      );
      tcLeadTimeList[index].text = "0";
    }
  }

  bool isValidStartDate(DateTime date) {
    final todayWithoutHour =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    if (date.isAfter(todayWithoutHour) || date == todayWithoutHour) {
      return true;
    }

    return false;
  }

  void saveUpdatedSelectedApproval() {
    if (!isValidStartDate(
        DateTime.parse(selectedApproval.value.dtmPlanStartDate))) {
      Fluttertoast.showToast(msg: "Plan Start Date minimal hari ini");
    } else {
      approvals[approvals.indexWhere((e) =>
              e.intProjectId == selectedApproval.value.intProjectId &&
              e.intProjectTaskId == selectedApproval.value.intProjectTaskId)] =
          selectedApproval.value;
      navigatorKey.currentContext!.pop();
      if (!selectedProjectIDs.contains(approvals[approvals.indexWhere(
              (e) => e.intProjectId == selectedApproval.value.intProjectId)]
          .intProjectTaskId)) {
        selectedProjectIDs.add(approvals[approvals.indexWhere((e) =>
                e.intProjectId == selectedApproval.value.intProjectId &&
                e.intProjectTaskId == selectedApproval.value.intProjectTaskId)]
            .intProjectTaskId);
      }
    }
  }

  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  void onPickDate() async {
    final date = await AppDialog.datePicker();
    if (date != null) {
      DateTime newEndDate =
          calculateDate(date, selectedApproval.value.intLeadTime);
      selectedApproval.value = selectedApproval.value.copyWith(
        dtmPlanStartDate: DateFormat('yyyy-MM-ddTHH:mm:ss').format(date),
        dtmPlanEndDate: DateFormat('yyyy-MM-ddTHH:mm:ss').format(newEndDate),
      );
    }
  }

  void onPickDateTable(int index) async {
    final date = await AppDialog.datePicker();
    if (date != null) {
      DateTime newEndDate = calculateDate(date, approvals[index].intLeadTime);
      approvals[index] = approvals[index].copyWith(
        dtmPlanStartDate: DateFormat('yyyy-MM-ddTHH:mm:ss').format(date),
        dtmPlanEndDate: DateFormat('yyyy-MM-ddTHH:mm:ss').format(newEndDate),
      );
    }
  }

  DateTime calculateDate(DateTime date, int leadtime) {
    int daysToAdd = 0;
    while (daysToAdd < leadtime) {
      date = date.add(const Duration(days: 1));
      if (!isWeekend(date)) {
        daysToAdd++;
      }
    }
    return date;
  }

  void onCompleteEditLead() async {
    isSubLoading.value = true;
    if (tcLeadTime.text.isEmpty) {
      tcLeadTime.text = "0";
    }
    selectedApproval.value = selectedApproval.value
        .copyWith(intLeadTime: int.parse(tcLeadTime.text));
    await getTaskEffortCategory();
    Future.delayed(const Duration(seconds: 2), () {
      isSubLoading.value = false;
    });
    DateTime newEndDate = calculateDate(
        DateTime.parse(selectedApproval.value.dtmPlanStartDate),
        selectedApproval.value.intLeadTime);
    selectedApproval.value = selectedApproval.value.copyWith(
      dtmPlanEndDate: DateFormat('yyyy-MM-ddTHH:mm:ss').format(newEndDate),
    );
  }

  void onCompleteEditLeadTable(int index) async {
    await getTaskEffortCategoryTable(index);
    Future.delayed(const Duration(seconds: 2), () {
      isSubLoading.value = false;
    });
    DateTime newEndDate = calculateDate(
        DateTime.parse(approvals[index].dtmPlanStartDate),
        int.parse(tcLeadTimeList[index].text));
    approvals[index] = approvals[index].copyWith(
      dtmPlanEndDate: DateFormat('yyyy-MM-ddTHH:mm:ss').format(newEndDate),
      intLeadTime: int.parse(tcLeadTimeList[index].text),
    );
  }

  bool isCheckedPlanStartDate(DateTime date) {
    return date.isAfter(DateTime.now()) ||
        (date.day == DateTime.now().day &&
            date.month == DateTime.now().month &&
            date.year == DateTime.now().year);
  }

  void approveTask() async {
    if (selectedLeader.value == projectLeaderEmpty) {
      Fluttertoast.showToast(msg: "Pilih resource terlebih dahulu");
    } else if (selectedProjectIDs.isEmpty) {
      Fluttertoast.showToast(msg: "Pilih task terlebih dahulu");
    } else {
      isSubLoading.value = true;
      List<Map<String, dynamic>> listBody = [];
      bool shouldExecution = true;

      if (shouldExecution) {
        for (int i = 0; i < selectedProjectIDs.length; i++) {
          final indexSelected = approvals
              .indexWhere((e) => e.intProjectTaskId == selectedProjectIDs[i]);
          if (isCheckedPlanStartDate(
              DateTime.parse(approvals[indexSelected].dtmPlanStartDate))) {
            final body = {
              "txtUpdatedBy": user.value.objData.txtUserName,
              "txtDeptCode": approvals[indexSelected].txtDeptCode,
              "txtResourceCode": approvals[indexSelected].txtResourceCode,
              "txtResourceName": approvals[indexSelected].txtResourceName,
              "txtCategory": approvals[indexSelected].txtCategory,
              "txtCategoryType": approvals[indexSelected].txtCategoryType,
              "intLeadTime": approvals[indexSelected].intLeadTime,
              "intProjectTaskID": approvals[indexSelected].intProjectTaskId,
              "dtmPlanStartDate": approvals[indexSelected].dtmPlanStartDate,
              "dtmPlanEndDate": approvals[indexSelected].dtmPlanEndDate,
              "bitApproved": true,
              "intProjectID": approvals[indexSelected].intProjectId,
              "txtEmployeeID": user.value.objData.txtEmployeeId,
              "txtUserID": user.value.objData.intUserId.toString(),
              "txtProjectObjectiveDesc":
                  approvals[indexSelected].txtProjectObjectiveDesc,
              "txtTaskDescription": approvals[indexSelected].txtTaskDescription,
            };
            listBody.add(body);
          } else {
            shouldExecution = false;
          }
        }
      }

      if (shouldExecution) {
        final response = await _approvalRepository.approvedTask(listBody);
        response.fold((fail) {
          isSubLoading.value = false;
          Fluttertoast.showToast(msg: fail);
        }, (data) async {
          await getApprovalTaskByLead();
          selectedProjectIDs.clear();
          isSubLoading.value = false;
        });
      } else {
        Fluttertoast.showToast(msg: "Ada tanggal yang tidak sesuai");
      }
      isSubLoading.value = false;
    }
  }
}
