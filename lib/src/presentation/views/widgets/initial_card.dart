import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/entities/initial_project.dart';

import '../../../utils/common/app_common.dart';
import '../../../utils/config/app_route_name.dart';

class InitialCard extends StatelessWidget {
  const InitialCard({super.key, required this.data});

  final InitialProjectObjData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context
          .goNamed(AppRouteName.mytask, extra: {"search": data.txtProjectCode}),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(
                horizontal: AppConstanta.sizes.defaultPadding),
            width: AppConstanta.sizes.width,
            height: 185,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: data.intProgressValue == 0
                  ? const Color.fromARGB(255, 247, 89, 77).withOpacity(0.9)
                  : data.intProgressValue <= 40
                      ? const Color.fromARGB(255, 245, 168, 52)
                      : data.intProgressValue <= 80
                          ? Colors.lightGreen.withOpacity(0.6)
                          : Colors.green,
            ),
          ),
          Container(
            width: 175,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
              border: Border(
                right: BorderSide(
                  color: Colors.white24,
                  width: 30,
                ),
                bottom: BorderSide(
                  color: Colors.white24,
                  width: 30,
                ),
              ),
            ),
          ),
          Container(
            width: AppConstanta.sizes.width,
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(
                horizontal: AppConstanta.sizes.defaultPadding,
                vertical: AppConstanta.sizes.defaultPadding),
            margin: EdgeInsets.symmetric(
              horizontal: AppConstanta.sizes.defaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: AppText.labelW600(
                        "${data.intProgressValue}%",
                        12,
                        Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.labelNormal(
                          data.txtDocReference,
                          12,
                          Colors.black,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        AppText.labelW600(
                          data.txtResourceName,
                          14,
                          Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                FittedBox(
                  child: AppText.labelBold(
                    data.txtProjectName,
                    18,
                    Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: AppConstanta.sizes.defaultPadding,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: data.intProgressValue == 0
                        ? const Color.fromARGB(255, 241, 150, 144)
                        : data.intProgressValue <= 40
                            ? const Color.fromARGB(255, 245, 204, 142)
                            : data.intProgressValue <= 80
                                ? const Color.fromARGB(255, 205, 243, 161)
                                    .withOpacity(0.6)
                                : Colors.green.withAlpha(10),
                  ),
                  child: AppText.labelNormal(
                    data.txtProjectCode,
                    12,
                    Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            width: AppConstanta.sizes.width,
            margin: EdgeInsets.symmetric(
                horizontal: AppConstanta.sizes.defaultPadding),
            child: Row(
              children: [
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(16),
                    ),
                    color: Colors.white,
                  ),
                  alignment: Alignment.centerRight,
                  child: AppText.labelW500(
                    "RSC : ${data.txtResourceCode}",
                    11.5,
                    Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
