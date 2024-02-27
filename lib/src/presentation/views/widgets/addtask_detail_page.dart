// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pman/src/presentation/views/loading_page.dart';
import 'package:pman/src/presentation/views/widgets/addtask_assign_tab.dart';
import 'package:pman/src/presentation/views/widgets/addtask_detail_tab.dart';

import '../../../utils/common/app_common.dart';
import '../../controllers/execution_detail_controller.dart';

class AddTaskDetailPage extends StatelessWidget {
  AddTaskDetailPage({super.key});

  final _aC = Get.find<ExecutionProjectDetailController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () async => await _aC.handleBack(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: _aC.handleBack,
              icon: Icon(
                Platform.isAndroid
                    ? Icons.arrow_back_rounded
                    : Icons.arrow_back_ios_rounded,
              ),
            ),
            toolbarHeight: 60,
            automaticallyImplyLeading: true,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            title: AppText.labelW600(
              AppConstanta.strings.projectExecutionDetail,
              16,
              Colors.black,
            ).tr(),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight - 10),
              child: TabBar(
                indicatorWeight: 4,
                indicatorColor: colorAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                    child: AppText.labelW600(
                      "assign",
                      15,
                      Colors.black,
                    ).tr(),
                  ),
                  Tab(
                    child: AppText.labelW600(
                      "detail",
                      15,
                      Colors.black,
                    ).tr(),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: _aC.assignTask,
                icon: const Icon(
                  Icons.save_as_rounded,
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              TabBarView(
                children: [
                  AddTaskAssignTab(),
                  AddTaskDetailTab(),
                ],
              ),
              Obx(() {
                if (_aC.isLoadingSubmit.value) {
                  return Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: AppConstanta.sizes.height,
                    child: const LoadingPage(),
                  );
                }
                return const SizedBox();
              })
            ],
          ),
        ),
      ),
    );
  }
}
