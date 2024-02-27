import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pman/src/entities/mytask.dart';

import '../../../utils/common/app_common.dart';

class MyTaskCard extends StatelessWidget {
  const MyTaskCard({
    super.key,
    required this.data,
    required this.ontap,
    required this.isOverdue,
  });

  final MyTaskObjData data;
  final bool isOverdue;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: ontap,
        child: Card(
          elevation: 2,
          color: isOverdue ? Colors.red.shade300 : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 20, horizontal: AppConstanta.sizes.defaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.labelBold(
                                  data.txtProjectCode,
                                  10,
                                  Colors.black54,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                AppText.labelW500(
                                  data.txtTaskDescription,
                                  12,
                                  Colors.black87,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                AppText.labelW400(
                                  data.txtStatus,
                                  12,
                                  Colors.black54,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                AppText.labelW500(
                                  data.txtProjectObjectiveDesc,
                                  12,
                                  Colors.black87,
                                  maxLines: 2,
                                  height: 1.5,
                                ),
                              ],
                            ),
                          ),
                          CircularPercentIndicator(
                            radius: 25.0,
                            lineWidth: 6.0,
                            animation: true,
                            percent: data.intProgressValue / 100,
                            center: AppText.labelW600(
                              "${data.intProgressValue}%",
                              12,
                              Colors.black,
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: data.intProgressValue <= 30
                                ? Colors.red
                                : data.intProgressValue <= 60
                                    ? colorAccent
                                    : Colors.lightGreen,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        height: 2,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.date_range_rounded,
                            size: 20,
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.labelW500(
                                "Start Date",
                                10,
                                Colors.black,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              AppText.labelW500(
                                DateFormat("dd/MM/yyyy").format(
                                    DateTime.parse(data.dtmPlanStartDate)),
                                12,
                                Colors.black54,
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.date_range_rounded,
                            size: 18,
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.labelW500(
                                "End Date",
                                10,
                                Colors.black,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              AppText.labelW500(
                                DateFormat("dd/MM/yyyy").format(
                                    DateTime.parse(data.dtmPlanEndDate)),
                                12,
                                Colors.black54,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 35,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
