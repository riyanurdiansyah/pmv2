import 'package:flutter/material.dart';
import 'package:pman/src/utils/common/app_common.dart';
import 'package:pman/src/utils/config/app_router.dart';

class AppSnackbar {
  static show({
    required String title,
  }) {
    return ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: AppText.labelW500(
          title,
          12.5,
          Colors.white,
        ),
      ),
    );
  }
}
