import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pman/src/entities/mytask.dart';
import 'package:pman/src/presentation/controllers/mytask_controller.dart';
import 'package:pman/src/presentation/views/empty_page.dart';
import 'package:pman/src/presentation/views/loading_page.dart';
import 'package:pman/src/utils/common/app_bottom_dialog.dart';

import '../../utils/common/app_common.dart';
import 'widgets/mytask_card.dart';

class MyTaskPage extends StatelessWidget {
  MyTaskPage({super.key});

  final _mC = Get.find<MyTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorAccent,
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0.5,
        backgroundColor: colorAccent,
        title: AppText.labelW600(
          "mytask",
          16,
          Colors.white,
        ).tr(),
        actions: [
          Obx(() {
            if (_mC.isLoading.value) {
              return const SizedBox();
            }
            return IconButton(
              onPressed: () => AppBottomDialog.filterMyTask(),
              icon: const Icon(
                Icons.filter_alt_rounded,
              ),
            );
          })
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Obx(() {
                if (_mC.isLoading.value) {
                  return const SizedBox();
                }

                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: double.infinity,
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      enableInteractiveSelection: false,
                      controller: _mC.tcSearch,
                      onChanged: _mC.onSearchTask,
                      style: const TextStyle(
                        height: 1.4,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "cari...",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          wordSpacing: 4,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        suffixIcon: Obx(() {
                          if (!_mC.isSearch.value) {
                            return const SizedBox();
                          }
                          return IconButton(
                            onPressed: () {
                              _mC.tcSearch.clear();
                              _mC.onSearchTask("");
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                            ),
                          );
                        }),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: colorPrimaryDark),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              Expanded(
                child: Obx(
                  () {
                    List<MyTaskObjData> mytasks = [];
                    if (_mC.isSearch.value || _mC.isFilter.value) {
                      mytasks = _mC.mytasksSearch
                          .where((e) => e.page == _mC.page.value)
                          .toList();
                    } else {
                      mytasks = _mC.mytasks
                          .where((e) => e.page == _mC.page.value)
                          .toList();
                    }

                    if (_mC.isLoading.value) {
                      return const LoadingPage();
                    }

                    if (mytasks.isEmpty) {
                      return const EmptyPage();
                    }

                    mytasks.sort((b, a) => DateTime.parse(b.dtmPlanEndDate)
                        .compareTo(DateTime.parse(a.dtmPlanEndDate)));
                    return RefreshIndicator(
                      onRefresh: _mC.getTasks,
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            mytasks.length,
                            (index) => MyTaskCard(
                              isOverdue:
                                  DateTime.parse(mytasks[index].dtmPlanEndDate)
                                      .isBefore(DateTime.now()),
                              key: ValueKey<String>("myTaskCard_$index"),
                              data: mytasks[index],
                              ontap: () => _mC.onTapTask(mytasks[index]),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Obx(() {
            if (_mC.isLoadingSubmit.value) {
              return Container(
                width: double.infinity,
                height: AppConstanta.sizes.height,
                color: Colors.transparent,
                child: const LoadingPage(),
              );
            }
            return const SizedBox();
          })
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          List<MyTaskObjData> mytasks = [];
          if (_mC.mytasksSearch.isNotEmpty || _mC.tcSearch.text.isNotEmpty) {
            mytasks = _mC.mytasksSearch;
          } else {
            mytasks = _mC.mytasks;
          }
          if (_mC.isLoading.value) {
            return const SizedBox();
          }
          return Container(
            color: Colors.white,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton.icon(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)))),
                    onPressed: _mC.page.value == 1
                        ? null
                        : () => _mC.onChangePage(_mC.page.value - 1),
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: AppText.labelW600(
                        "«",
                        20,
                        _mC.page.value == 1 ? Colors.grey : colorPrimaryDark,
                      ),
                    ),
                    label: AppText.labelW600(
                      "previous",
                      14,
                      _mC.page.value == 1 ? Colors.grey : colorPrimaryDark,
                    ).tr(),
                  ),
                ),
                Container(
                  width: 2,
                  height: 50,
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  key: const Key("btnSelanjutnyaMyTask"),
                  child: TextButton.icon(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)))),
                    onPressed: _mC.page.value >= (mytasks.length / 4).ceil()
                        ? null
                        : () => _mC.onChangePage(_mC.page.value + 1),
                    label: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: AppText.labelW600(
                        "»",
                        20,
                        _mC.page.value >= (mytasks.length / 4).ceil()
                            ? Colors.grey
                            : colorPrimaryDark,
                      ),
                    ),
                    icon: AppText.labelW600(
                      "next",
                      14,
                      _mC.page.value >= (mytasks.length / 4).ceil()
                          ? Colors.grey
                          : colorPrimaryDark,
                    ).tr(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
