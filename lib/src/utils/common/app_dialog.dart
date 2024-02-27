import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/presentation/controllers/profile_controller.dart';
import 'package:pman/src/utils/common/app_common.dart';

import '../config/app_router.dart';

class AppDialog {
  static popUpExit() {
    return showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppConstantaImages.exit,
                width: 120,
              ),
              const SizedBox(
                height: 25,
              ),
              AppText.labelW600(
                "wantLeave",
                14,
                Colors.black,
              ).tr(),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () => navigatorKey.currentContext?.pop(),
                      child: AppText.labelW600(
                        "cancel",
                        14,
                        AppConstanta.colors.colorPrimaryDark,
                      ).tr(),
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          AppConstanta.colors.colorPrimaryDark,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () => exit(0),
                      child: AppText.labelW600(
                        "yes",
                        14,
                        Colors.white,
                      ).tr(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static popUpBackExecution({
    required int lengTask,
    required VoidCallback onNext,
    required VoidCallback ontap,
  }) {
    return showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.labelNormal(
                "Ada $lengTask task yang belum disave. \nData akan hilang jika kamu keluar.",
                14,
                Colors.black,
                maxLines: 6,
                textAlign: TextAlign.center,
                height: 1.6,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            width: 0.8,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      onPressed: onNext,
                      child: AppText.labelW600(
                        "Hapus",
                        12,
                        Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          AppConstanta.colors.colorPrimaryDark,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: ontap,
                      child: AppText.labelW600(
                        "Simpan draft",
                        12,
                        Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static loading() {
    return showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => SpinKitChasingDots(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index.isEven ? colorPrimary : colorPrimaryDark,
            ),
          );
        },
      ),
    );
  }

  static confirmation({
    String? title,
    String? subtitle,
    Function()? ontap,
  }) {
    return showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: AppText.labelW600(
          title ?? "Keluar",
          14,
          Colors.black,
        ),
        content: AppText.labelW500(
          subtitle ?? "Yakin ingin keluar?",
          12,
          Colors.black54,
        ),
        actions: [
          ElevatedButton(
            onPressed: ontap,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(colorPrimaryDark)),
            child: AppText.labelW600(
              "Lanjut",
              12,
              Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  static Future<DateTime?> datePicker() async {
    return await showDatePicker(
      context: navigatorKey.currentContext!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      initialDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: "Plan Start Date",
    );
  }

  static chooseRole() {
    final hC = Get.find<ProfileController>();
    return showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              hC.user.value.objData.ltRoles.length,
              (index) => InkWell(
                child: InkWell(
                  onTap: () =>
                      hC.onSelectRole(hC.user.value.objData.ltRoles[index]),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        AppText.labelW500(
                          hC.user.value.objData.ltRoles[index].txtRoleName,
                          14,
                          Colors.black,
                        ),
                        const Spacer(),
                        Obx(
                          () => Radio(
                            activeColor: colorPrimaryDark,
                            value: hC.user.value.objData.ltRoles[index],
                            groupValue: hC.selectedRole.value,
                            onChanged: hC.onSelectRole,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static choosLanguage() {
    final pC = Get.find<ProfileController>();

    return showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              AppConstanta.lists.languages.length,
              (index) => InkWell(
                child: InkWell(
                  onTap: () => pC
                      .onSelectedLanguage(AppConstanta.lists.languages[index]),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        AppText.labelW500(
                          AppConstanta.lists.languages[index].name,
                          14,
                          Colors.black,
                        ),
                        const Spacer(),
                        Radio(
                          activeColor: colorPrimaryDark,
                          value: AppConstanta.lists.languages[index].locale,
                          groupValue:
                              EasyLocalization.of(navigatorKey.currentContext!)!
                                  .currentLocale!,
                          onChanged: (val) {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static notifTask() {
    return showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.labelW600(
                "Ada 1 task baru untukmu",
                16,
                Colors.black,
              ),
            ],
          ),
        );
      },
    );
  }
}
