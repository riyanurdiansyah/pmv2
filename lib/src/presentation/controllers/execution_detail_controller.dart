import 'dart:convert';

import 'package:business_logic/business_logic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/entities/approval_category.dart';
import 'package:pman/src/entities/resource.dart';
import 'package:pman/src/utils/common/app_common.dart';
import 'package:pman/src/utils/config/app_dependency_injection.dart';
import 'package:pman/src/utils/config/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../entities/execution_project_detail.dart';
import '../../entities/project_task_date.dart';
import '../../entities/task_effort_category.dart';
import '../../entities/user.dart';

class ExecutionProjectDetailController extends GetxController {
  late SharedPreferences prefs;

  final approvalRepository = getIt<ApprovalRepository>();

  final executionRepository = getIt<ExecutionRepository>();

  final MyTaskRepository myTaskRepository = getIt<MyTaskRepository>();

  final Rx<ExecutionProjectDetailEntity> execution =
      ExecutionProjectDetailEntity.emptyObject().obs;

  Map<String, dynamic> bodyRequest = {};

  RxList<TrProjectObjectiveMilestoneTaskDetail> tasks =
      <TrProjectObjectiveMilestoneTaskDetail>[].obs;

  Rx<ResourceObjData> selectedResource = ResourceObjData.emptyObject().obs;

  Rx<ApprovalCategoryObjData> selectedAppCategory =
      ApprovalCategoryObjData.emptyObject().obs;

  final Rx<UserEntity> user = UserEntity.emptyObject().obs;

  final Rx<LtRole> selectedRole = LtRole.emptyObject().obs;

  final Rx<bool> isLoadingSubmit = false.obs;

  final Rx<ProjectTaskDateEntity> projectTaskDate =
      ProjectTaskDateEntity.emptyObject().obs;

  @override
  void onInit() async {
    await setup();
    Future.delayed(const Duration(seconds: 1), () async {
      await getProjectObjectiveMilestoneDetail();
    });
    super.onInit();
  }

  Future getTaskDate(String employeeId) async {
    final body = {
      "txtResourceCode": employeeId,
    };
    final response = await myTaskRepository.getTaskDate(request: body);
    response.fold((fail) {
      projectTaskDate.value = projectTaskDate.value.copyWith(
        txtStackTrace: fail,
      );
    }, (data) {
      projectTaskDate.value = ProjectTaskDateEntity.fromJson(data);
    });
  }

  Future setup() async {
    prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString("user");
    final userRole = prefs.getString("role");
    if (userString != null && userRole != null) {
      user.value = UserEntity.fromJson(json.decode(userString));
      selectedRole.value = LtRole.fromJson(json.decode(userRole));
    }
  }

  Future getProjectObjectiveMilestoneDetail() async {
    final response = await executionRepository
        .getProjectObjectiveMilestoneDetail(body: bodyRequest);
    response.fold(
      (fail) {
        execution.value = execution.value.copyWith(
          txtStackTrace: fail,
        );
        Fluttertoast.showToast(msg: fail);
      },
      (data) async {
        execution.value = ExecutionProjectDetailEntity.fromJson(data);
        tasks.value = execution
            .value
            .objData
            .trProjectObjectiveMilestoneDetail[0]
            .trProjectObjectiveMilestoneTaskDetail;
        if (execution.value != ExecutionProjectDetailEntity.emptyObject()) {
          final stringListTemp = prefs.getString(
              "${user.value.objData.txtEmployeeId}%%${execution.value.objData.txtProjectObjectiveCode}%%${execution.value.objData.trProjectObjectiveMilestoneDetail[0].txtMilestone}");

          if (stringListTemp != null) {
            final rawListTemp = json.decode(stringListTemp) as List<dynamic>;
            for (var data in rawListTemp) {
              var objData =
                  TrProjectObjectiveMilestoneTaskDetail.fromJson(data);
              objData = objData.copyWith(isEdit: true);
              tasks.add(objData);
            }
          }
        }
      },
    );
  }

  void addTaskDetail(TrProjectObjectiveMilestoneTaskDetail data) {
    tasks.add(data);
  }

  void updateTaskDetail(TrProjectObjectiveMilestoneTaskDetail data) {
    final index = tasks.indexWhere((e) => e.idTemp == data.idTemp);

    tasks[index] = data;
  }

  void deleteTaskDetail(TrProjectObjectiveMilestoneTaskDetail data) async {
    tasks.remove(data);
  }

  Future<List<ResourceObjData>> getResurces(String text) async {
    final body = {"txtSearch": ""};
    final response = await executionRepository.getResourceLOV(body: body);
    return response.map((e) => ResourceObjData.fromJson(e)).toList();
  }

  Future<List<ApprovalCategoryObjData>> getAppCategory(String text) async {
    final body = {
      "txtUserId": user.value.objData.txtEmployeeId,
      "bitSuperUser": selectedRole.value.bitSuperuser ? 1 : 0,
      "txtSearch": "",
      "txtParam": execution
          .value.objData.trProjectObjectiveMilestoneDetail[0].txtMilestone,
    };
    final response = await executionRepository.getAppCategoryLOV(body: body);
    return response.map((e) => ApprovalCategoryObjData.fromJson(e)).toList();
  }

  Future<TaskEffortCategoryEntity?> getTaskEffortCategory(int leadtime) async {
    final data = TaskEffortCategoryObjRequest(
      intLeadtime: leadtime,
      txtDeptCode: execution.value.objData.txtDepartmentCode,
      txtMilestone: execution
          .value.objData.trProjectObjectiveMilestoneDetail[0].txtMilestone,
    );
    final response =
        await approvalRepository.getTaskEffortCategory(data.toJson());
    return response.fold(
      (fail) {
        return null;
      },
      (rawData) async {
        return TaskEffortCategoryEntity.fromJson(rawData);
      },
    );
  }

  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  DateTime calculateDate(DateTime date, int leadtime) {
    int daysToAdd = 1;
    while (daysToAdd < leadtime) {
      date = date.add(const Duration(days: 1));
      if (!isWeekend(date)) {
        daysToAdd++;
      }
    }
    return date;
  }

  Future onChangeResource(ResourceObjData? value) async {
    if (value != null) {
      selectedResource.value = value;
      getTaskDate(selectedResource.value.txtNik);
    }
  }

  void onSelectAppCategory(ApprovalCategoryObjData? value) {
    if (value != null) {
      selectedAppCategory.value = value;
    }
  }

  void assignTask() async {
    isLoadingSubmit.value = true;
    execution.value.objData.trProjectObjectiveMilestoneDetail[0] =
        execution.value.objData.trProjectObjectiveMilestoneDetail[0].copyWith(
      trProjectObjectiveMilestoneTaskDetail: tasks
          .where((e) => e.intProjectObjectiveMilestoneTaskDetailId == 0)
          .toList(),
    );
    final body = execution.value.objData.toJson();

    body["txtEmployeeID"] = user.value.objData.txtEmployeeId;
    body["txtUserName"] = user.value.objData.txtUserName;
    body["txtNIK"] = "";
    body["txtGUID"] = const Uuid().v4();

    final response = await executionRepository.assignTask(body: body);
    response.fold((fail) => Fluttertoast.showToast(msg: fail), (data) async {
      if (data["bitSuccess"] == false) {
        Fluttertoast.showToast(msg: data["txtMessage"]);
      } else {
        prefs.remove(
            "${user.value.objData.txtEmployeeId}%%${execution.value.objData.txtProjectObjectiveCode}%%${execution.value.objData.trProjectObjectiveMilestoneDetail[0].txtMilestone}");
        await getProjectObjectiveMilestoneDetail();
      }
      await Future.delayed(Duration.zero, () {
        isLoadingSubmit.value = false;
      });
    });
  }

  Future handleBack() async {
    final listTemp = tasks.where((e) => e.isEdit == true).toList();
    if (listTemp.isEmpty) {
      navigatorKey.currentContext!.pop();
    } else {
      AppDialog.popUpBackExecution(
        lengTask: listTemp.length,
        onNext: backRemoveDraft,
        ontap: saveToDraft,
      );
    }
  }

  void backRemoveDraft() {
    prefs.remove(
        "${user.value.objData.txtEmployeeId}%%${execution.value.objData.txtProjectObjectiveCode}%%${execution.value.objData.trProjectObjectiveMilestoneDetail[0].txtMilestone}");
    navigatorKey.currentContext!.pop();
    navigatorKey.currentContext!.pop();
  }

  void saveToDraft() {
    final listTemp = tasks.where((e) => e.isEdit == true).toList();
    prefs.setString(
        "${user.value.objData.txtEmployeeId}%%${execution.value.objData.txtProjectObjectiveCode}%%${execution.value.objData.trProjectObjectiveMilestoneDetail[0].txtMilestone}",
        json.encode(listTemp));
    navigatorKey.currentContext!.pop();
    navigatorKey.currentContext!.pop();
  }
}
