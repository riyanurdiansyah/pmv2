import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pman/src/presentation/controllers/signin_controller.dart';

import '../../utils/common/app_common.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final _sC = Get.find<SigninController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                AppConstantaImages.logo,
                scale: 16 / 8,
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: colorAccent,
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: AppConstanta.sizes.defaultPadding),
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstanta.sizes.defaultPadding,
                    vertical: AppConstanta.sizes.defaultPadding + 10),
                child: Form(
                  key: _sC.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText.labelW500(
                        "Username",
                        14,
                        colorPrimary,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        key: const Key("tcUsenameLogin"),
                        controller: _sC.tcUsername,
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: textFieldAuthDecoration(
                            fontSize: 14, hintText: "johndoe", radius: 4),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) => AppValidator.requiredField(val!,
                            errorMsg: "Username tidak boleh kosong"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppText.labelW500(
                        "Password",
                        14,
                        colorPrimary,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => TextFormField(
                          enableInteractiveSelection: false,
                          key: const Key("tcPasswordLogin"),
                          controller: _sC.tcPassword,
                          obscureText: _sC.isObsecure.value,
                          textInputAction: TextInputAction.done,
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          decoration: textFieldPassDecoration(
                            fontSize: 14,
                            hintText: "*********",
                            radius: 4,
                            onTap: _sC.onChangeObsecure,
                          ),
                          onEditingComplete: _sC.signin,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) => AppValidator.requiredField(val!,
                              errorMsg: "Password tidak boleh kosong"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          key: const Key("btnMasukLogin"),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(colorPrimaryDark),
                          ),
                          onPressed: _sC.signin,
                          child: AppText.labelBold(
                            "MASUK",
                            14,
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      height: 2,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  AppText.labelW600(
                    "or",
                    14,
                    Colors.grey,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      height: 2,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _sC.signInWithSSO(true);
                },
                icon: const Icon(Icons.home),
                label: AppText.labelW600(
                  "Sign in with Office 365",
                  14,
                  Colors.black,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: AppConstanta.sizes.width,
        padding:
            EdgeInsets.symmetric(vertical: AppConstanta.sizes.defaultPadding),
        child: AppText.labelW500(
          "copyright @IT Kalbe Nutritionals 2023",
          12,
          colorPrimaryDark,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
