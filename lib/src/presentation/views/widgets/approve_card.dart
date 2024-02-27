import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pman/src/entities/approval.dart';
import 'package:pman/src/presentation/controllers/approve_controller.dart';

import '../../../utils/common/app_common.dart';

class ApproveCard extends StatelessWidget {
  ApproveCard({
    super.key,
    required this.data,
  });

  final ApprovalObjData data;

  final _aC = Get.find<ApproveController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: () => _aC.selectCardApproval(data),
        child: Card(
          color: Colors.white,
          elevation: 0.4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 20, horizontal: AppConstanta.sizes.defaultPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.labelW600(
                            data.txtProjectName,
                            12,
                            Colors.black,
                            maxLines: 2,
                            height: 1.25,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: AppConstanta.sizes.defaultPadding,
                          ),
                          AppText.labelW500(
                            data.txtTaskDescription,
                            12,
                            Colors.grey,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Transform.scale(
                        scale: 1.2,
                        child: Obx(
                          () => Checkbox(
                            activeColor: colorPrimaryDark,
                            value: _aC.selectedProjectIDs
                                .contains(data.intProjectTaskId),
                            onChanged: (val) {
                              if (_aC.selectedProjectIDs
                                  .contains(data.intProjectTaskId)) {
                                _aC.selectedProjectIDs.removeWhere(
                                    (e) => e == data.intProjectTaskId);
                              } else {
                                if (!_aC.isValidStartDate(
                                    DateTime.parse(data.dtmPlanStartDate))) {
                                  Fluttertoast.showToast(
                                      msg: "Plan Start Date minimal hari ini");
                                } else {
                                  _aC.selectedProjectIDs
                                      .add(data.intProjectTaskId);
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppConstanta.sizes.defaultPadding,
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.grey.shade300,
                ),
                SizedBox(
                  height: AppConstanta.sizes.defaultPadding,
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
                              dotenv.get("USE_EXAMPLE") == "true"
                                  ? DateTime.now()
                                  : DateTime.parse(data.dtmPlanStartDate)),
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
                              dotenv.get("USE_EXAMPLE") == "true"
                                  ? DateTime.now()
                                  : DateTime.parse(data.dtmPlanEndDate)),
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
        ),
      ),
    );
  }
}
