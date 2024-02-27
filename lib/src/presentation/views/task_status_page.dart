import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../entities/log_task_status.dart';
import '../../utils/common/app_common.dart';
import '../controllers/home_controller.dart';
import 'widgets/home_task_status.dart';

class TaskStatusPage extends StatelessWidget {
  TaskStatusPage({super.key});

  final _hC = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: AppText.labelW600(
            "History Task",
            14,
            Colors.black,
          ),
        ),
        body: ListView(
          children: [
            Obx(
              () => HomeTaskStatusWidget(
                dateBefore: _hC.dateBefore,
                logsToday: _hC.logTaskToday,
                logsYesterday: _hC.logTaskYesterday,
                logs2DBefore: _hC.logTask2DBefore,
                ontap: _hC.onTapTaskStatus,
                isLoading: _hC.logTaskStatus.value ==
                    LogTaskStatusEntity.emptyObject(),
              ),
            ),
          ],
        ));
  }
}
