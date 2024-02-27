import 'dart:convert';

import 'package:business_logic/business_logic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/entities/language.dart';
import 'package:pman/src/presentation/controllers/home_controller.dart';
import 'package:pman/src/utils/config/app_route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user.dart';
import '../../utils/common/app_common.dart';
import '../../utils/config/app_dependency_injection.dart';
import '../../utils/config/app_router.dart';
import 'dashboard_controller.dart';

class ProfileController extends GetxController {
  late SharedPreferences prefs;
  NotifRepository notifRepository = getIt<NotifRepository>();
  AuthRepository authRepository = getIt<AuthRepository>();

  final Rx<UserEntity> user = UserEntity.emptyObject().obs;

  final Rx<LtRole> selectedRole = LtRole.emptyObject().obs;

  @override
  void onInit() async {
    await setup();
    super.onInit();
  }

  Future setup() async {
    prefs = await SharedPreferences.getInstance();

    final userString = prefs.getString("user");
    final userRole = prefs.getString("role");
    if (userString != null && userRole != null) {
      user.value = UserEntity.fromJson(json.decode(userString));
      selectedRole.value = LtRole.fromJson(json.decode(userRole));
    }
  }

  String getInitials(String fullname) {
    return notifRepository.getInitials(fullname);
  }

  String getLanguage(String locale) {
    return notifRepository.getLanguage(locale);
  }

  void onSelectedLanguage(LanguageEntity language) {
    // selectedLanguage.value = language;
    navigatorKey.currentContext!.setLocale(language.locale);
    navigatorKey.currentContext!.pop();
  }

  void onSelectRole(LtRole? newValue) async {
    if (newValue != null) {
      selectedRole.value = newValue;
      prefs.setString("role", json.encode(selectedRole.value.toJson()));
      navigatorKey.currentContext!.pop();
      await setup();
    }
  }

  void logout() async {
    navigatorKey.currentContext!.pop();
    AppDialog.loading();
    storeToken();
    prefs.clear();
    Get.delete<DashboardController>();
    Get.delete<HomeController>();
    navigatorKey.currentContext!.goNamed(AppRouteName.signin);
  }

  void storeToken() async {
    final body = {
      "intUserID": user.value.objData.intUserId,
      "txtUserGUID": user.value.txtGuid,
      "txtToken": "",
      "txtEmployeeID": user.value.objData.txtEmployeeId,
    };
    authRepository.storeToken(request: body);
  }
}
