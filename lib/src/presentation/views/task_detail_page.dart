import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pman/src/entities/approval_category.dart';
import 'package:pman/src/entities/execution_project_detail.dart';
import 'package:pman/src/entities/project_task_date.dart';
import 'package:pman/src/presentation/controllers/execution_detail_controller.dart';
import 'package:pman/src/utils/common/app_common.dart';
import 'package:uuid/uuid.dart';

import '../../entities/resource.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key, this.data});

  final TrProjectObjectiveMilestoneTaskDetail? data;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final Rx<bool> isLoading = false.obs;
  final _eC = Get.find<ExecutionProjectDetailController>();

  final tcDescription = TextEditingController();
  final tcLeadTime = TextEditingController(text: "1");
  final tcStartDate = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  final tcEndDate = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  final tcAssignment = TextEditingController();
  // final tcCategory = TextEditingController();
  final tcEffort = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final RxList<ProjectTaskDateObjData> tasks = <ProjectTaskDateObjData>[].obs;

  final _focusNodeLead = FocusNode();

  @override
  void initState() {
    if (widget.data != null) {
      final data = widget.data!;
      tcDescription.text = data.txtTaskDescription;
      tcLeadTime.text = data.intLeadTime.toString();
      tcEffort.text = data.txtCategoryType;
      tcStartDate.text = DateFormat("dd/MM/yyyy")
          .format(DateTime.parse(data.dtmPlanStartDate));
      tcEndDate.text =
          DateFormat("dd/MM/yyyy").format(DateTime.parse(data.dtmPlanEndDate));

      _eC.selectedAppCategory.value = ApprovalCategoryObjData(
        intDetailId: _eC
            .execution
            .value
            .objData
            .trProjectObjectiveMilestoneDetail[0]
            .intProjectObjectiveMilestoneDetailId,
        txtDescription: data.txtCategory,
        txtMilestone: _eC.execution.value.objData
            .trProjectObjectiveMilestoneDetail[0].txtMilestone,
      );

      _eC.selectedResource.value = ResourceObjData(
        txtNik: data.txtResourceCode,
        txtNickName: "",
        txtResourceName: data.txtResourceName,
        txtJobTitle: "",
        txtDepartmentCode: data.txtDeptCode,
        txtDepartmentName: "",
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _eC.selectedResource.value = ResourceObjData.emptyObject();
    _eC.selectedAppCategory.value = ApprovalCategoryObjData.emptyObject();
    tcDescription.dispose();
    tcLeadTime.dispose();
    tcStartDate.dispose();
    tcEndDate.dispose();
    tcAssignment.dispose();
    // tcCategory.dispose();
    tcEffort.dispose();
    _focusNodeLead.dispose();
    _eC.projectTaskDate.value = ProjectTaskDateEntity.emptyObject();
    super.dispose();
  }

  Future onCompleteEditLead() async {
    if (tcLeadTime.text.isEmpty) {
      tcLeadTime.text = "0";
    }
    final result = await _eC.getTaskEffortCategory(int.parse(tcLeadTime.text));
    if (result != null) {
      tcEffort.text = result.objData.txtTaskEffortCategory;
      DateTime newEndDate = _eC.calculateDate(
          DateFormat("dd/MM/yyyy").parse(tcStartDate.text),
          int.parse(tcLeadTime.text));
      tcEndDate.text = DateFormat("dd/MM/yyyy").format(newEndDate);
    }
  }

  void onPickDate() async {
    final date = await AppDialog.datePicker();
    if (date != null) {
      DateTime newEndDate = _eC.calculateDate(date, int.parse(tcLeadTime.text));
      tcStartDate.text = DateFormat("dd/MM/yyyy").format(date);
      tcEndDate.text = DateFormat("dd/MM/yyyy").format(newEndDate);
      countTasks();
    }
  }

  void onChangeLead(String lead) {
    DateTime newEndDate = _eC.calculateDate(
        DateFormat("dd/MM/yyyy").parse(tcStartDate.text), int.parse(lead));
    tcEndDate.text = DateFormat("dd/MM/yyyy").format(newEndDate);
  }

  Future countTasks() async {
    tasks.value = _eC.projectTaskDate.value.objData.where((e) {
      final start = DateTime.parse(e.start);
      final end = DateTime.parse(e.end);
      return start.isBefore(DateFormat("dd/MM/yyyy").parse(tcStartDate.text)) &&
          end.isAfter(DateFormat("dd/MM/yyyy").parse(tcStartDate.text));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: AppText.labelW600(
          "Task Detail",
          14,
          Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Obx(() {
                if (_eC.projectTaskDate.value.objData.isEmpty ||
                    tasks.isEmpty) {
                  return const SizedBox();
                }
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  color: Colors.red,
                  width: double.infinity,
                  child: AppText.labelW500(
                    "Resource memiliki ${tasks.length} task di tanggal tersebut",
                    12,
                    Colors.white,
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstanta.sizes.defaultPadding,
                  vertical: AppConstanta.sizes.defaultPadding,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppText.labelW600(
                            "Task Description",
                            14,
                            Colors.black,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          AppText.labelBold(
                            "*",
                            16,
                            Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        enableInteractiveSelection: false,
                        controller: tcDescription,
                        validator: (val) => AppValidator.requiredField(val!),
                        decoration: textFieldAuthDecoration(
                          fontSize: 12,
                          hintText: "Description",
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          AppText.labelW600(
                            "Task Assignment",
                            14,
                            Colors.black,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          AppText.labelBold(
                            "*",
                            16,
                            Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DropdownSearch<ResourceObjData>(
                        popupProps: PopupProps.menu(
                          fit: FlexFit.loose,
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: textFieldAuthDecoration(
                              fontSize: 12,
                              hintText: "Cari berdasarkan nama",
                            ),
                          ),
                        ),
                        validator: (val) => AppValidator.requiredField(
                            _eC.selectedResource.value.txtResourceName),
                        selectedItem: _eC.selectedResource.value,
                        asyncItems: _eC.getResurces,
                        itemAsString: (ResourceObjData u) => u.txtResourceName,
                        onChanged: (val) async {
                          await _eC.onChangeResource(val);
                          await countTasks();
                        },
                        onSaved: (val) => countTasks(),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: textFieldAuthDecoration(
                            fontSize: 12,
                            hintText: "Resource",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          AppText.labelW600(
                            "Task Category",
                            14,
                            Colors.black,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          AppText.labelBold(
                            "*",
                            16,
                            Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DropdownSearch<ApprovalCategoryObjData>(
                        popupProps: PopupProps.menu(
                          fit: FlexFit.loose,
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: textFieldAuthDecoration(
                              fontSize: 12,
                              hintText: "Cari berdasarkan nama",
                            ),
                          ),
                        ),
                        validator: (val) => AppValidator.requiredField(
                            _eC.selectedAppCategory.value.txtDescription),
                        selectedItem: _eC.selectedAppCategory.value,
                        asyncItems: _eC.getAppCategory,
                        itemAsString: (ApprovalCategoryObjData u) =>
                            u.txtDescription,
                        onChanged: _eC.onSelectAppCategory,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: textFieldAuthDecoration(
                            fontSize: 12,
                            hintText: "Resource",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AppText.labelW600(
                                    "Lead Time",
                                    14,
                                    Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  AppText.labelBold(
                                    "*",
                                    16,
                                    Colors.red,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                width: 80,
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  controller: tcLeadTime,
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3)
                                  ],
                                  focusNode: _focusNodeLead,
                                  onChanged: (val) {
                                    if (val.isNotEmpty) {
                                      onChangeLead(val);
                                    }
                                  },
                                  // validator: (val) {
                                  //   if (val == null ||
                                  //       val.isEmpty ||
                                  //       val == "0") {
                                  //     Fluttertoast.showToast(msg: "WOI");
                                  //   }
                                  //   return null;
                                  // },
                                  decoration: textFieldAuthDecoration(
                                      fontSize: 10, hintText: ""),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.labelW600(
                                  "Plan Start Date",
                                  14,
                                  Colors.black,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextFormField(
                                  enableInteractiveSelection: false,
                                  controller: tcStartDate,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  onTap: onPickDate,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3)
                                  ],
                                  validator: (val) =>
                                      AppValidator.requiredField(val!),
                                  onEditingComplete: () {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    // aC.onCompleteEditLead();
                                  },
                                  decoration: textFieldAuthDecoration(
                                      fontSize: 10, hintText: ""),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.labelW600(
                                  "Plan End Date",
                                  14,
                                  Colors.black,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextFormField(
                                  enableInteractiveSelection: false,
                                  controller: tcEndDate,
                                  readOnly: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3)
                                  ],
                                  validator: (val) =>
                                      AppValidator.requiredField(val!),
                                  onEditingComplete: () {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    // aC.onCompleteEditLead();
                                  },
                                  decoration: textFieldAuthDecoration(
                                      fontSize: 10, hintText: ""),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(colorPrimaryDark),
                          ),
                          onPressed: () async {
                            // await onCompleteEditLead().then((value) {
                            if (formKey.currentState!.validate()) {
                              if (tcLeadTime.text.isEmpty) {
                                _focusNodeLead.requestFocus();
                                Fluttertoast.showToast(
                                    msg: "Lead time tidak boleh kosong");
                              } else if (tcLeadTime.text == "0") {
                                _focusNodeLead.requestFocus();
                                Fluttertoast.showToast(
                                    msg: "Lead time harus lebih besar dari 0");
                              } else {
                                isLoading.value = true;
                                await onCompleteEditLead().whenComplete(() {
                                  if (widget.data == null) {
                                    _eC.addTaskDetail(
                                      TrProjectObjectiveMilestoneTaskDetail(
                                        intProjectObjectiveMilestoneTaskDetailId:
                                            0,
                                        intProjectObjectiveMilestoneDetailId: 0,
                                        intProjectTaskId: 0,
                                        txtTaskDescription: tcDescription.text,
                                        txtCategory: _eC.selectedAppCategory
                                            .value.txtDescription,
                                        txtCategoryType: tcEffort.text,
                                        txtDeptCode: _eC.selectedResource.value
                                            .txtDepartmentCode,
                                        txtResourceCode:
                                            _eC.selectedResource.value.txtNik,
                                        txtResourceName: _eC.selectedResource
                                            .value.txtResourceName,
                                        intLeadTime: int.parse(tcLeadTime.text),
                                        dtmPlanStartDate:
                                            DateFormat("dd/MM/yyyy")
                                                .parse(tcStartDate.text)
                                                .toIso8601String(),
                                        dtmPlanEndDate: DateFormat("dd/MM/yyyy")
                                            .parse(tcEndDate.text)
                                            .toIso8601String(),
                                        dtmActualStartDate: null,
                                        dtmActualEndDate: null,
                                        txtNotes: tcDescription.text,
                                        bitApproved: true,
                                        bitRejected: false,
                                        bitActive: true,
                                        txtInsertedBy: null,
                                        dtmInsertedDate: null,
                                        txtUpdatedBy: null,
                                        dtmUpdatedDate: null,
                                        trProjectObjectiveMilestoneDetail: null,
                                        isEdit: true,
                                        idTemp: const Uuid().v4(),
                                        txtGUID: "",
                                      ),
                                    );
                                  } else {
                                    _eC.updateTaskDetail(
                                      TrProjectObjectiveMilestoneTaskDetail(
                                        intProjectObjectiveMilestoneTaskDetailId:
                                            0,
                                        intProjectObjectiveMilestoneDetailId: 0,
                                        intProjectTaskId: 0,
                                        txtTaskDescription: tcDescription.text,
                                        txtCategory: _eC.selectedAppCategory
                                            .value.txtDescription,
                                        txtCategoryType: tcEffort.text,
                                        txtDeptCode: _eC.selectedResource.value
                                            .txtDepartmentCode,
                                        txtResourceCode:
                                            _eC.selectedResource.value.txtNik,
                                        txtResourceName: _eC.selectedResource
                                            .value.txtResourceName,
                                        intLeadTime: int.parse(tcLeadTime.text),
                                        dtmPlanStartDate:
                                            DateFormat("dd/MM/yyyy")
                                                .parse(tcStartDate.text)
                                                .toIso8601String(),
                                        dtmPlanEndDate: DateFormat("dd/MM/yyyy")
                                            .parse(tcEndDate.text)
                                            .toIso8601String(),
                                        dtmActualStartDate: null,
                                        dtmActualEndDate: null,
                                        txtNotes: null,
                                        bitApproved: true,
                                        bitRejected: false,
                                        bitActive: true,
                                        txtInsertedBy: null,
                                        dtmInsertedDate: null,
                                        txtUpdatedBy: null,
                                        dtmUpdatedDate: null,
                                        trProjectObjectiveMilestoneDetail: null,
                                        isEdit: true,
                                        idTemp: widget.data!.idTemp,
                                        txtGUID: "",
                                      ),
                                    );
                                  }
                                  context.pop();
                                });
                                isLoading.value = false;
                              }
                            }
                          },
                          child: AppText.labelW600(
                            "SIMPAN",
                            14,
                            Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Obx(() {
            if (isLoading.isFalse) {
              return const SizedBox();
            }

            return Container(
              width: AppConstanta.sizes.width,
              height: AppConstanta.sizes.height,
              color: Colors.transparent,
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorPrimaryDark,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const CupertinoActivityIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
