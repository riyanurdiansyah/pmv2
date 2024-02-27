import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pman/src/presentation/controllers/profile_controller.dart';
import 'package:pman/src/utils/common/app_common.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final _pC = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: ListView(
          children: [
            Obx(
              () => Container(
                width: double.infinity,
                height: AppConstanta.sizes.height / 3.6,
                color: colorAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: AppText.labelW600(
                        _pC
                            .getInitials(_pC.user.value.objData.txtFullName)
                            .toUpperCase(),
                        25,
                        Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    AppText.labelW600(
                      _pC.user.value.objData.txtFullName.toUpperCase(),
                      16,
                      Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText.labelW600(
                      _pC.user.value.objData.txtEmployeeId,
                      12,
                      Colors.white,
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 20,
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: InkWell(
                      onTap: () => AppDialog.chooseRole(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.person_rounded,
                            size: 18,
                            color: colorPrimaryDark,
                          ),
                          SizedBox(
                            width: AppConstanta.sizes.defaultPadding,
                          ),
                          AppText.labelW600(
                            AppConstanta.strings.role,
                            12,
                            Colors.black,
                          ).tr(),
                          const Spacer(),
                          Obx(
                            () => InkWell(
                              onTap: () => AppDialog.chooseRole(),
                              child: AppText.labelW600(
                                _pC.selectedRole.value.txtRoleName,
                                14,
                                Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 2.6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: InkWell(
                      onTap: () => AppDialog.choosLanguage(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.language_rounded,
                            size: 18,
                            color: colorPrimaryDark,
                          ),
                          SizedBox(
                            width: AppConstanta.sizes.defaultPadding,
                          ),
                          AppText.labelW600(
                            _pC.getLanguage(EasyLocalization.of(context)!
                                .currentLocale
                                .toString()),
                            12,
                            Colors.black,
                          ).tr(),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 2.6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.shield_lefthalf_fill,
                          size: 18,
                          color: colorPrimaryDark,
                        ),
                        SizedBox(
                          width: AppConstanta.sizes.defaultPadding,
                        ),
                        AppText.labelW600(
                          AppConstanta.strings.version,
                          12,
                          Colors.black,
                        ).tr(),
                        const Spacer(),
                        Obx(
                          () => AppText.labelW600(
                            "v${dotenv.get("VERSION")}",
                            14,
                            Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 2.6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: InkWell(
                      onTap: () => AppDialog.confirmation(ontap: () async {
                        _pC.logout();
                      }),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: AppConstanta.sizes.defaultPadding,
                          ),
                          AppText.labelW600(
                            AppConstanta.strings.signout,
                            12,
                            Colors.red,
                          ).tr(),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
