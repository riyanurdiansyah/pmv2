import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/presentation/controllers/home_controller.dart';
import 'package:pman/src/presentation/views/widgets/home_menu.dart';
import 'package:pman/src/presentation/views/widgets/home_task_status.dart';
import 'package:pman/src/presentation/views/widgets/initial.dart';
import 'package:pman/src/utils/common/app_common.dart';
import 'package:pman/src/utils/config/app_route_name.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _hC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade100,
        bottom: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstanta.sizes.defaultPadding,
            ),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstanta.strings.hello,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ).tr(),
                        Text(
                          _hC.user.value.objData.txtFullName.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => context.pushNamed(AppRouteName.notification),
                    child: SizedBox(
                      width: 30,
                      child: Stack(
                        children: [
                          const Icon(
                            Icons.notifications_rounded,
                          ),
                          Obx(() {
                            if (_hC.histories
                                .where((e) => e.isRead == 0)
                                .toList()
                                .isNotEmpty) {
                              return Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 14,
                                  height: 14,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: AppText.labelW600(
                                    _hC.histories
                                        .where((e) => e.isRead == 0)
                                        .toList()
                                        .length
                                        .toString(),
                                    10,
                                    Colors.white,
                                  ),
                                ),
                              );
                            }

                            return const SizedBox();
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            InitialWidget(),
            const SizedBox(
              height: 25,
            ),
            const HomeMenuWidget(),
            const SizedBox(
              height: 25,
            ),
            Obx(() {
              return HomeTaskStatusWidget(
                lengthLog: 3,
                dateBefore: _hC.dateBefore,
                logsToday: _hC.logTaskToday,
                logsYesterday: _hC.logTaskYesterday,
                logs2DBefore: _hC.logTask2DBefore,
                ontap: _hC.onTapTaskStatus,
                isLoading: _hC.isLoadingLog.value,
              );
            }),
          ],
        ),
      ),
    );
  }
}
