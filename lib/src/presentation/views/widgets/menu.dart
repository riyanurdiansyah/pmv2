import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/entities/menus.dart';

import '../../../utils/common/app_common.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
    required this.menu,
  });

  final MenuEntity menu;

  @override
  Widget build(BuildContext context) {
    if (menu.itemList.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          selectedColor: Colors.amber,
          focusColor: Colors.red,
          selectedTileColor: Colors.black,
          onTap: () {
            context.go(menu.txtLink);
          },
          title: AppText.labelW600(
            menu.txtMenuName,
            14,
            colorPrimaryDark.withOpacity(0.4),
          ),
        ),
      );
    }
    menu.itemList.sort((a, b) => a.txtMenuName.compareTo(b.txtMenuName));
    return ExpansionTile(
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      childrenPadding: const EdgeInsets.only(left: 6),
      leading: const Icon(
        Icons.grid_3x3_rounded,
        size: 16.0, // Sesuaikan ukuran ikon sesuai kebutuhan Anda
      ),
      title: AppText.labelW600(
        menu.txtMenuName,
        14,
        colorPrimaryDark,
      ),
      iconColor: colorPrimaryDark,
      collapsedIconColor: colorPrimaryDark,
      children: List.generate(menu.itemList.length, (index) {
        if (menu.itemList[index].itemList.isEmpty) {
          if (index + 1 == menu.itemList.length) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Menu(
                menu: menu.itemList[index],
              ),
            );
          }
          return Menu(
            menu: menu.itemList[index],
          );
        }
        return Submenu(
          submenus: menu.itemList[index].itemList,
        );
      }),
    );
  }
}

class Submenu extends StatelessWidget {
  const Submenu({
    super.key,
    required this.submenus,
  });

  final List<MenuEntity> submenus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: submenus.map(
        (submenu) {
          return ListTile(
            onTap: () {},
            leading: const Icon(Icons.home_rounded),
            title: AppText.labelW600(
              submenu.txtMenuName,
              14,
              colorPrimaryDark,
            ),
          );
        },
      ).toList(),
    );
  }
}
