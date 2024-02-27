import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/common/app_common.dart';
import '../../../utils/config/app_route_name.dart';

class HomeMenuWidget extends StatelessWidget {
  const HomeMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AppText.labelBold(
            AppConstanta.strings.menu,
            14,
            Colors.black,
          ).tr(),
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => context.goNamed(AppRouteName.mytask),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        AppConstantaImages.mytask,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: AppConstanta.sizes.defaultPadding,
                    ),
                    AppText.labelW600(
                      AppConstanta.strings.mytask,
                      12.5,
                      Colors.black,
                    ).tr(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => context.goNamed(AppRouteName.approve),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        AppConstantaImages.approval,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: AppConstanta.sizes.defaultPadding,
                    ),
                    AppText.labelW600(
                      AppConstanta.strings.approval,
                      12.5,
                      Colors.black,
                    ).tr(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => context.pushNamed(AppRouteName.executionProject),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        AppConstantaImages.addtask,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: AppConstanta.sizes.defaultPadding,
                    ),
                    AppText.labelW600(
                      AppConstanta.strings.addtask,
                      12.5,
                      Colors.black,
                    ).tr(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => context.pushNamed(AppRouteName.event),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        AppConstantaImages.calendar,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: AppConstanta.sizes.defaultPadding,
                    ),
                    AppText.labelW600(
                      AppConstanta.strings.calendar,
                      12.5,
                      Colors.black,
                    ).tr(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
