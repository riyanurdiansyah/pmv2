import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/presentation/controllers/dashboard_controller.dart';
import 'package:pman/src/utils/config/app_route_name.dart';

import '../../utils/common/app_common.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({
    super.key,
    required this.widget,
    required this.route,
  });

  final Widget widget;
  final String route;

  final _dC = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: false,
      backgroundColor: Colors.grey.shade100,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 40),
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () => context.pushNamed(AppRouteName.executionProject),
          elevation: 0,
          backgroundColor: colorPrimaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: const BorderSide(
              width: 5,
              color: Colors.white,
            ),
          ),
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
            weight: 10,
            size: 30,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    if (route.contains(AppRouteName.home))
                      Container(
                        height: 2,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: colorPrimaryDark,
                        ),
                      ),
                    IconButton(
                      onPressed: () => context.goNamed(AppRouteName.home),
                      icon: Icon(
                        CupertinoIcons.house_fill,
                        size: 20,
                        color: route.contains(AppRouteName.home)
                            ? colorPrimaryDark
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    if (route.contains(AppRouteName.mytask))
                      Container(
                        width: 60,
                        height: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: colorPrimaryDark,
                        ),
                      ),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () => context.goNamed(AppRouteName.mytask),
                          icon: Icon(
                            CupertinoIcons.doc_person_fill,
                            size: 20,
                            color: route.contains(AppRouteName.mytask)
                                ? colorPrimaryDark
                                : Colors.grey,
                          ),
                        ),
                        Obx(() {
                          if (_dC.countTasks.value > 0) {
                            return Container(
                              width: 50,
                              padding: const EdgeInsets.only(top: 6, right: 6),
                              alignment: Alignment.topRight,
                              child: Container(
                                alignment: Alignment.center,
                                width: 14,
                                height: 14,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: AppText.labelW600(
                                  _dC.countTasks.value.toString(),
                                  10,
                                  Colors.white,
                                ),
                              ),
                            );
                          }

                          return const SizedBox();
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 80,
            ),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    if (route.contains(AppRouteName.approve))
                      Container(
                        width: 60,
                        height: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: colorPrimaryDark,
                        ),
                      ),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () =>
                              context.goNamed(AppRouteName.approve),
                          icon: Icon(
                            CupertinoIcons.doc_checkmark_fill,
                            size: 20,
                            color: route.contains(AppRouteName.approve)
                                ? colorPrimaryDark
                                : Colors.grey,
                          ),
                        ),
                        Obx(() {
                          if (_dC.countApprovals.value > 0) {
                            return Container(
                              width: 50,
                              padding: const EdgeInsets.only(top: 6, right: 6),
                              alignment: Alignment.topRight,
                              child: Container(
                                alignment: Alignment.center,
                                width: 14,
                                height: 14,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: AppText.labelW600(
                                  _dC.countApprovals.value.toString(),
                                  10,
                                  Colors.white,
                                ),
                              ),
                            );
                          }

                          return const SizedBox();
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    if (route.contains(AppRouteName.profile))
                      Container(
                        height: 2,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: colorPrimaryDark,
                        ),
                      ),
                    IconButton(
                      onPressed: () => context.goNamed(AppRouteName.profile),
                      icon: Icon(
                        CupertinoIcons.profile_circled,
                        size: 20,
                        color: route.contains(AppRouteName.profile)
                            ? colorPrimaryDark
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: widget,
    );
  }
}
