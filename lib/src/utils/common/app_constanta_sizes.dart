import 'package:flutter/material.dart';

import '../config/app_router.dart';

class AppConstantaSizes {
  double width = MediaQuery.of(navigatorKey.currentContext!).size.width;

  double height = MediaQuery.of(navigatorKey.currentContext!).size.height;

  double defaultPadding = 16.0;
}
