import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/entities/execution_project.dart';
import 'package:pman/src/presentation/controllers/execution_controller.dart';
import 'package:pman/src/presentation/views/empty_page.dart';
import 'package:pman/src/presentation/views/widgets/mytask_card_skeleton.dart';
import 'package:pman/src/utils/config/app_route_name.dart';

import '../../utils/common/app_common.dart';
import 'widgets/mytask_card.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});

  final _aC = Get.find<ExecutionProjectController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorAccent,
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0.5,
        backgroundColor: colorAccent,
        title: AppText.labelW600(
          AppConstanta.strings.projectExecutionDetail,
          16,
          Colors.white,
        ).tr(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: double.infinity,
            child: SizedBox(
              height: 40,
              child: TextFormField(
                enableInteractiveSelection: false,
                controller: _aC.tcSearch,
                onChanged: _aC.onSearchTask,
                style: const TextStyle(
                  height: 1.4,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: "cari...",
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    wordSpacing: 4,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red.shade300,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red.shade300,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  suffixIcon: Obx(() {
                    if (!_aC.isSearch.value) {
                      return const SizedBox();
                    }
                    return IconButton(
                      onPressed: () {
                        _aC.tcSearch.clear();
                        _aC.onSearchTask("");
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                      ),
                    );
                  }),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: colorPrimaryDark),
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Obx(() {
            if (_aC.executionProject.value ==
                ExecutionProjectEntity.emptyObject()) {
              return const MyTaskCardSkeleton();
            }

            List<ExecutionProjectObjData> executions = [];
            if (_aC.isSearch.value) {
              executions = _aC.executionsSearch;
            } else {
              executions = _aC.executions;
            }

            if (executions.isEmpty) {
              return SizedBox(
                height: AppConstanta.sizes.height / 2,
                child: const EmptyPage(),
              );
            }
            return Column(
              children: List.generate(executions.length, (index) {
                return MyTaskCard(
                  isOverdue: false,
                  key: ValueKey<String>("executionProject_$index"),
                  data: _aC.convertToMyTaskObjData(executions[index]),
                  ontap: () {
                    context.pushNamed(
                      AppRouteName.executionProjectDetail,
                      extra: {
                        "data": executions[index],
                        "request": {
                          "intProjectExecutionID":
                              executions[index].intProjectExecutionId,
                          "txtMilestone": executions[index].txtMilestone,
                          "txtPICResourceID": executions[index].txtResourceCode,
                        },
                      },
                    );
                  },
                );
              }),
            );
          }),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
