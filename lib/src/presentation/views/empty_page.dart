import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pman/src/utils/common/app_common.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppConstantaImages.empty,
          width: 150,
        ),
        const SizedBox(
          height: 50,
        ),
        AppText.labelW600(
          "notFoundData",
          14,
          Colors.grey.shade400,
        ).tr(),
      ],
    );
  }
}
