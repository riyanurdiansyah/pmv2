import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/utils/config/app_route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user.dart';
import '../../utils/config/app_router.dart';

class RoleController extends GetxController {
  late SharedPreferences prefs;
  final Rx<UserEntity> user = UserEntity.emptyObject().obs;

  final Rx<LtRole> selectedRole = LtRole.emptyObject().obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();

    final userString = prefs.getString("user");
    if (userString != null) {
      user.value = UserEntity.fromJson(json.decode(userString));
      if (user.value.objData.ltRoles.length == 1) {
        selectedRole.value = user.value.objData.ltRoles[0];
        saveRole();
      }
    }
    super.onInit();
  }

  void onSelectRole(LtRole? newValue) {
    if (newValue != null) {
      selectedRole.value = newValue;
    }
  }

  void saveRole() {
    if (formKey.currentState!.validate()) {
      prefs.setString("role", json.encode(selectedRole.value.toJson()));
      navigatorKey.currentContext!.goNamed(AppRouteName.home);
    }
  }
}
