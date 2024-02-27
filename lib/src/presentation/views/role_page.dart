import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pman/src/entities/user.dart';
import 'package:pman/src/presentation/controllers/role_controller.dart';

import '../../utils/common/app_common.dart';

class RolePage extends StatelessWidget {
  RolePage({super.key});

  final _rC = Get.find<RoleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAccent,
      appBar: AppBar(
        centerTitle: false,
        title: AppText.labelW600("Choose Role", 16, Colors.white),
        backgroundColor: colorAccent,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        key: const Key("btnRoleChoose"),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all(colorPrimaryDark.withOpacity(0.5))),
          onPressed: () => _rC.saveRole(),
          child: AppText.labelW600(
            "Choose",
            16,
            Colors.white,
          ),
        ),
      ),
      body: Obx(
        () => Form(
          key: _rC.formKey,
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: AppConstanta.sizes.defaultPadding,
                vertical: AppConstanta.sizes.defaultPadding),
            width: double.infinity,
            child: DropdownSearch<LtRole>(
              validator: (val) {
                if (_rC.selectedRole.value == LtRole.emptyObject()) {
                  return "Kolom tidak boleh kosong";
                }
                return null;
              },
              key: const Key("ddnRole"),
              popupProps: PopupProps.menu(
                itemBuilder: (context, role, _) {
                  return ListTile(
                    key: const Key("txtRole"),
                    title: AppText.labelW600(
                      role.txtRoleName,
                      14,
                      Colors.black54,
                    ),
                  );
                },
                showSearchBox: false,
                fit: FlexFit.loose,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      wordSpacing: 4,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: AppConstanta.sizes.defaultPadding),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              items: _rC.user.value.objData.ltRoles,
              onChanged: _rC.onSelectRole,
              itemAsString: (LtRole role) => role.txtRoleName,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: "....",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    wordSpacing: 4,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: AppConstanta.sizes.defaultPadding),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
