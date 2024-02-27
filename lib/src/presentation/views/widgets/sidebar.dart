import 'package:flutter/material.dart';

import '../../../utils/common/app_common.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
    required this.route,
  });

  final String route;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: AppConstanta.sizes.width / 1.5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      elevation: 0,
      child: Material(
        color: colorAccent,
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorPrimaryDark,
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"))),
                  ),
                  SizedBox(
                    height: AppConstanta.sizes.defaultPadding,
                  ),
                  AppText.labelW600(
                    "Riyan Nurdiansyah",
                    16,
                    Colors.black,
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: menus.length,
            //     shrinkWrap: true,
            //     itemBuilder: (BuildContext context, index) =>
            //         _buildMenu(menus[index]),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
