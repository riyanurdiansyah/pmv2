import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pman/src/utils/common/app_common.dart';
import 'package:pman/src/utils/config/app_route_name.dart';
import 'package:uuid/uuid.dart';

import '../../../entities/execution_project_detail.dart';
import '../../controllers/execution_detail_controller.dart';
import '../empty_page.dart';

class AddTaskAssignTab extends StatelessWidget {
  AddTaskAssignTab({super.key});

  final _aC = Get.find<ExecutionProjectDetailController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_aC.execution.value == ExecutionProjectDetailEntity.emptyObject()) {
          return const Center(
            child: CircularProgressIndicator(
              color: colorPrimaryDark,
            ),
          );
        }

        if (_aC.execution.value.txtStackTrace.isNotEmpty ||
            _aC.execution.value.objData ==
                ExecutionProjectDetailObjData.emptyObject() ||
            _aC.execution.value.objData.trProjectObjectiveMilestoneDetail
                .isEmpty) {
          return const EmptyPage();
        }
        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: FloatingActionButton.small(
              onPressed: () {
                context.pushNamed(AppRouteName.taskDetail);
              },
              backgroundColor: colorPrimaryDark,
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
              ),
            ),
          ),
          body: ListView(
            children: [
              Obx(() {
                if (_aC.tasks.isEmpty) {
                  return SizedBox(
                      height: AppConstanta.sizes.height / 1.5,
                      child: const EmptyPage());
                }
                return Column(
                    children: List.generate(
                        _aC.tasks
                            .map((e) => e.txtResourceName)
                            .toSet()
                            .toList()
                            .length, (index) {
                  final uniqueNames =
                      _aC.tasks.map((e) => e.txtResourceName).toSet().toList();
                  final currentName = uniqueNames.elementAt(index);

                  final tasksForName = _aC.tasks
                      .where((task) => task.txtResourceName == currentName)
                      .toList();
                  tasksForName.sort((a, b) =>
                      b.intProjectTaskId.compareTo(a.intProjectTaskId));
                  return ExpansionTile(
                    initiallyExpanded:
                        tasksForName.any((e) => e.isEdit == true),
                    backgroundColor: Colors.grey.shade100,
                    childrenPadding: EdgeInsets.zero,
                    title: AppText.labelW600(
                      currentName,
                      14,
                      Colors.black,
                    ),
                    children: List.generate(
                      tasksForName.length,
                      (subindex) => Slidable(
                        endActionPane: ActionPane(
                          extentRatio: 0.25,
                          motion: const ScrollMotion(),
                          dragDismissible: false,
                          children: [
                            if (tasksForName[subindex].isEdit == false)
                              SlidableAction(
                                autoClose: true,
                                onPressed: (_) => _aC.addTaskDetail(
                                    tasksForName[subindex].copyWith(
                                  isEdit: true,
                                  txtTaskDescription:
                                      "${tasksForName[subindex].txtTaskDescription} [Duplicate]",
                                  intProjectObjectiveMilestoneDetailId: 0,
                                  intProjectObjectiveMilestoneTaskDetailId: 0,
                                  trProjectObjectiveMilestoneDetail: null,
                                  dtmUpdatedDate: null,
                                  txtUpdatedBy: null,
                                  dtmInsertedDate: null,
                                  txtInsertedBy: null,
                                  bitApproved: true,
                                  bitRejected: false,
                                  bitActive: true,
                                  idTemp: const Uuid().v4(),
                                  txtResourceCode:
                                      tasksForName[subindex].txtResourceCode,
                                  txtResourceName:
                                      tasksForName[subindex].txtResourceName,
                                  txtCategory:
                                      tasksForName[subindex].txtCategory,
                                  txtCategoryType:
                                      tasksForName[subindex].txtCategoryType,
                                  dtmPlanStartDate: DateTime.parse(
                                              tasksForName[subindex]
                                                  .dtmPlanStartDate)
                                          .isBefore(DateTime.now())
                                      ? DateTime.now().toIso8601String()
                                      : tasksForName[subindex].dtmPlanStartDate,
                                  dtmPlanEndDate: DateTime.parse(
                                              tasksForName[subindex]
                                                  .dtmPlanStartDate)
                                          .isBefore(DateTime.now())
                                      ? _aC
                                          .calculateDate(
                                              DateTime.now(),
                                              tasksForName[subindex]
                                                  .intLeadTime)
                                          .toIso8601String()
                                      : tasksForName[subindex].dtmPlanEndDate,
                                  intLeadTime:
                                      tasksForName[subindex].intLeadTime,
                                  txtDeptCode:
                                      tasksForName[subindex].txtDeptCode,
                                  txtNotes: tasksForName[subindex].txtNotes,
                                )),
                                backgroundColor: colorAccent,
                                foregroundColor: Colors.white,
                                icon: Icons.content_copy_outlined,
                                label: 'Duplikat',
                              ),
                            if (tasksForName[subindex].isEdit == true)
                              SlidableAction(
                                onPressed: (_) => _aC
                                    .deleteTaskDetail(tasksForName[subindex]),
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                          ],
                        ),
                        child: ListTile(
                          style: ListTileStyle.list,
                          onTap: tasksForName[subindex].isEdit == false
                              ? null
                              : () => context.pushNamed(AppRouteName.taskDetail,
                                      extra: {
                                        "data": tasksForName[subindex],
                                      }),
                          title: AppText.labelW600(
                            tasksForName[subindex].txtTaskDescription,
                            14,
                            Colors.black,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              AppText.labelW600(
                                "#${tasksForName[subindex].txtCategory}",
                                14,
                                Colors.grey,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              AppText.labelW500(
                                "${DateFormat("dd/MM/yyyy").format(DateTime.parse(tasksForName[subindex].dtmPlanStartDate))} to ${DateFormat("dd/MM/yyyy").format(DateTime.parse(tasksForName[subindex].dtmPlanEndDate))}",
                                10.5,
                                Colors.grey,
                              ),
                            ],
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              bottom: 0,
                              right: 0.0,
                              left: 0,
                            ),
                            child: Icon(
                              tasksForName[subindex].isEdit
                                  ? CupertinoIcons.xmark_circle_fill
                                  : CupertinoIcons.checkmark_alt_circle_fill,
                              color: tasksForName[subindex].isEdit
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }));
              }),
            ],
          ),
        );
      },
    );
  }
}
