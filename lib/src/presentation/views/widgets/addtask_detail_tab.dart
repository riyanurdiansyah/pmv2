import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pman/src/entities/execution_project_detail.dart';
import 'package:pman/src/presentation/views/empty_page.dart';
import 'package:pman/src/utils/common/app_common.dart';

import '../../controllers/execution_detail_controller.dart';

class AddTaskDetailTab extends StatelessWidget {
  AddTaskDetailTab({super.key});

  final _aC = Get.find<ExecutionProjectDetailController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_aC.execution.value == ExecutionProjectDetailEntity.emptyObject()) {
        return const Center(
          child: CircularProgressIndicator(
            color: colorPrimaryDark,
          ),
        );
      }

      if (_aC.execution.value.txtStackTrace.isNotEmpty) {
        return const EmptyPage();
      }
      return ListView(
        padding: EdgeInsets.symmetric(
            horizontal: AppConstanta.sizes.defaultPadding, vertical: 25),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.labelW400(
                "Document No.",
                12.5,
                Colors.grey.shade600,
              ),
              Expanded(
                child: AppText.labelBold(
                  _aC.execution.value.objData.txtProjectObjectiveCode,
                  12.5,
                  Colors.black,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.labelW400(
                "Project Initiative.",
                12.5,
                Colors.grey.shade600,
              ),
              Expanded(
                child: AppText.labelBold(
                  _aC.execution.value.objData.txtProjectName,
                  12.5,
                  Colors.black,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.labelW400(
                "Project Objective.",
                12.5,
                Colors.grey.shade600,
              ),
              Expanded(
                child: AppText.labelBold(
                  _aC.execution.value.objData.txtProjectObjectiveDesc,
                  12.5,
                  Colors.black,
                  maxLines: 5,
                  textAlign: TextAlign.end,
                  height: 1.25,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.labelW400(
                "Project Leader.",
                12.5,
                Colors.grey.shade600,
              ),
              Expanded(
                child: AppText.labelBold(
                  _aC.execution.value.objData.txtPicResourceName,
                  12.5,
                  Colors.black,
                  maxLines: 5,
                  textAlign: TextAlign.end,
                  height: 1.25,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.labelW400(
                "Department.",
                12.5,
                Colors.grey.shade600,
              ),
              Expanded(
                child: AppText.labelBold(
                  _aC.execution.value.objData.txtDepartmentName,
                  12.5,
                  Colors.black,
                  maxLines: 5,
                  textAlign: TextAlign.end,
                  height: 1.25,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            height: 2,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.labelW400(
                "Milestone.",
                12.5,
                Colors.grey.shade600,
              ),
              AppText.labelBold(
                _aC.execution.value.objData.trProjectObjectiveMilestoneDetail[0]
                    .txtMilestone,
                12.5,
                Colors.black,
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.labelW400(
                "Project Team.",
                12.5,
                Colors.grey.shade600,
              ),
              AppText.labelBold(
                _aC.execution.value.objData.trProjectObjectiveMilestoneDetail[0]
                    .txtProjectLeaderName,
                12.5,
                Colors.black,
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.labelW400(
                "Weight.",
                12.5,
                Colors.grey.shade600,
              ),
              AppText.labelBold(
                _aC.execution.value.objData.trProjectObjectiveMilestoneDetail[0]
                    .decWeight
                    .toString(),
                12.5,
                Colors.black,
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.labelW400(
                "Lead Time.",
                12.5,
                Colors.grey.shade600,
              ),
              AppText.labelBold(
                _aC.execution.value.objData.trProjectObjectiveMilestoneDetail[0]
                    .intLeadTime
                    .toString(),
                12.5,
                Colors.black,
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.labelW400(
                "Start Date Project.",
                12.5,
                Colors.grey.shade600,
              ),
              AppText.labelBold(
                _aC.execution.value.objData.trProjectObjectiveMilestoneDetail[0]
                            .dtmPlanStartDate !=
                        null
                    ? DateFormat("dd/MM/yyyy").format(DateTime.parse(_aC
                        .execution
                        .value
                        .objData
                        .trProjectObjectiveMilestoneDetail[0]
                        .dtmPlanStartDate))
                    : "-",
                12.5,
                Colors.black,
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.labelW400(
                "End Date Project.",
                12.5,
                Colors.grey.shade600,
              ),
              AppText.labelBold(
                _aC.execution.value.objData.trProjectObjectiveMilestoneDetail[0]
                            .dtmPlanStartDate !=
                        null
                    ? DateFormat("dd/MM/yyyy").format(DateTime.parse(_aC
                        .execution
                        .value
                        .objData
                        .trProjectObjectiveMilestoneDetail[0]
                        .dtmPlanEndDate))
                    : "-",
                12.5,
                Colors.black,
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            height: 2,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      );
    });
  }
}
