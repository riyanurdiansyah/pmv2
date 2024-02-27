import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/entities/log_task_status.dart';
import 'package:pman/src/presentation/views/widgets/home_task_status_skeleton.dart';
import 'package:pman/src/utils/common/app_common.dart';
import 'package:pman/src/utils/config/app_route_name.dart';

class HomeTaskStatusWidget extends StatelessWidget {
  const HomeTaskStatusWidget({
    super.key,
    required this.dateBefore,
    required this.ontap,
    required this.logsToday,
    required this.logsYesterday,
    required this.logs2DBefore,
    required this.isLoading,
    this.lengthLog,
  });

  final Rx<int> dateBefore;
  final List<LogTaskStatusObjData> logsToday;
  final List<LogTaskStatusObjData> logsYesterday;
  final List<LogTaskStatusObjData> logs2DBefore;
  final bool isLoading;
  final Function(int) ontap;
  final int? lengthLog;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<LogTaskStatusObjData> logs = [];
      int maxLog = 0;
      if (dateBefore.value == 0) {
        logs = logsToday;
      } else if (dateBefore.value == 1) {
        logs = logsYesterday;
      } else {
        logs = logs2DBefore;
      }

      if (lengthLog != null) {
        maxLog = lengthLog ?? 0;
      } else {
        maxLog = logs.length;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (lengthLog != null)
            SizedBox(
              height: AppConstanta.sizes.defaultPadding,
            ),
          if (lengthLog != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.labelBold(
                    AppConstanta.strings.historyTask,
                    14,
                    Colors.black,
                  ).tr(),
                  InkWell(
                    onTap: () => context.pushNamed(AppRouteName.log),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText.labelW600(
                        AppConstanta.strings.showAll,
                        12,
                        AppConstanta.colors.colorPrimaryDark,
                      ).tr(),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstanta.sizes.defaultPadding,
              vertical: AppConstanta.sizes.defaultPadding,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: () => ontap(0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: AppConstanta.sizes.defaultPadding,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: dateBefore.value == 0
                              ? colorPrimaryDark
                              : Colors.grey.shade400,
                          width: 2,
                        ),
                        color: dateBefore.value == 0
                            ? Colors.grey.shade200
                            : Colors.grey.shade400,
                      ),
                      child: Row(
                        children: [
                          AppText.labelW600(
                            AppConstanta.strings.today,
                            14,
                            dateBefore.value == 0
                                ? colorPrimaryDark
                                : Colors.white,
                          ).tr(),
                          AppText.labelW600(
                            "(${logsToday.length})",
                            14,
                            dateBefore.value == 0
                                ? colorPrimaryDark
                                : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () => ontap(1),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: AppConstanta.sizes.defaultPadding,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: dateBefore.value == 1
                              ? colorPrimaryDark
                              : Colors.grey.shade400,
                          width: 2,
                        ),
                        color: dateBefore.value == 1
                            ? Colors.grey.shade200
                            : Colors.grey.shade400,
                      ),
                      child: Row(
                        children: [
                          AppText.labelW600(
                            AppConstanta.strings.yesterday,
                            14,
                            dateBefore.value == 1
                                ? colorPrimaryDark
                                : Colors.white,
                          ).tr(),
                          AppText.labelW600(
                            "(${logsYesterday.length})",
                            14,
                            dateBefore.value == 1
                                ? colorPrimaryDark
                                : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () => ontap(2),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: AppConstanta.sizes.defaultPadding,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: dateBefore.value == 2
                              ? colorPrimaryDark
                              : Colors.grey.shade400,
                          width: 2,
                        ),
                        color: dateBefore.value == 2
                            ? Colors.grey.shade200
                            : Colors.grey.shade400,
                      ),
                      child: Row(
                        children: [
                          AppText.labelW600(
                            AppConstanta.strings.ddBefore,
                            14,
                            dateBefore.value == 2
                                ? colorPrimaryDark
                                : Colors.white,
                          ).tr(),
                          AppText.labelW600(
                            "(${logs2DBefore.length})",
                            14,
                            dateBefore.value == 2
                                ? colorPrimaryDark
                                : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading) const HomeTaskStatusSkeleton(),
          if (!isLoading && logs.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: AppText.labelW600(
                  "noActivity",
                  14,
                  Colors.grey,
                ).tr(),
              ),
            ),
          if (logs.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstanta.sizes.defaultPadding, vertical: 10),
              child: Column(
                children: List.generate(
                  logs.length > maxLog ? maxLog : logs.length,
                  (index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppConstanta.colors.colorPrimaryDark,
                              border: Border.all(
                                width: 3.5,
                                color: AppConstanta.colors.colorPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          if (index !=
                              ((logs.length > maxLog ? maxLog : logs.length) -
                                  1))
                            Container(
                              color: Colors.grey.shade100,
                              width: 10,
                              height: 50,
                              child: LayoutBuilder(
                                builder: (context, constraint) => Flex(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  direction: Axis.vertical,
                                  children: List.generate(
                                    (constraint.constrainHeight() / 15).floor(),
                                    (index) => SizedBox(
                                      width: 6,
                                      height: 6,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade400,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.labelBold(
                              logs[index].txtStatus,
                              12,
                              Colors.black,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            AppText.labelW600(
                              logs[index].txtTaskDescription,
                              12,
                              Colors.grey.shade600,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              height: 1.25,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: AppText.labelNormal(
                          "${logs[index].dtmInsertedDate.hour}.${logs[index].dtmInsertedDate.minute.toString().length == 1 ? "0${logs[index].dtmInsertedDate.minute.toString()}" : logs[index].dtmInsertedDate.minute.toString()} WIB",
                          12.5,
                          Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(
            height: 25,
          ),
        ],
      );
    });
  }
}
