import 'dart:convert';

import 'package:business_logic/business_logic.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/common/app_common.dart';
import '../../utils/config/app_route_name.dart';
import '../../utils/config/app_router.dart';

class SigninController extends GetxController {
  late SharedPreferences prefs;
  late AuthRemoteDatasource _authRemoteDatasource;
  late AuthRepository _authRepository;

  final Rx<bool> isObsecure = true.obs;

  final formKey = GlobalKey<FormState>();

  final tcUsername = TextEditingController();

  final tcPassword = TextEditingController();

  @override
  void onInit() async {
    await setup();
    super.onInit();
  }

  Future setup() async {
    prefs = await SharedPreferences.getInstance();
    _authRemoteDatasource = AuthRemoteDatasourceImpl();
    _authRepository = AuthRepositoryImpl(
      authRemoteDatasource: _authRemoteDatasource,
    );
  }

  void onChangeObsecure() {
    isObsecure.value = !isObsecure.value;
  }

  void signin() async {
    //

    if (formKey.currentState!.validate()) {
      AppDialog.loading();

      final body = {
        "username": tcUsername.text,
        "password": tcPassword.text,
      };

      final response = await _authRepository.signIn(request: body);
      response.fold(
        (fail) async {
          navigatorKey.currentContext!.pop();
          Fluttertoast.showToast(msg: "Gagal login.. $fail");
        },
        (data) async {
          final user = UserEntity.fromJson(data);
          if (!user.bitSuccess) {
            navigatorKey.currentContext!.pop();
            Fluttertoast.showToast(msg: "Gagal login.. ${user.txtMessage}");
          } else {
            storeToken(user);
            saveUserToSession(user);
            navigatorKey.currentContext!.goNamed(AppRouteName.role);
          }
        },
      );
    }
  }

  void storeToken(UserEntity user) async {
    final body = {
      "intUserID": user.objData.intUserId,
      "txtUserGUID": user.txtGuid,
      "txtToken": "",
      "txtEmployeeID": user.objData.txtEmployeeId,
    };

    _authRepository.storeToken(request: body);
  }

  void saveUserToSession(UserEntity user) {
    String userToString = json.encode(user.toJson());
    prefs.setString("user", userToString);
  }

  void signInWithSSO(bool redirect) async {}
}
