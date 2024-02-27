import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pman/src/entities/project_leader.dart';
import 'package:pman/src/presentation/controllers/approve_controller.dart';
import 'package:pman/src/presentation/views/approve_list_page.dart';
import 'package:pman/src/presentation/views/approve_table_page.dart';
import 'package:pman/src/presentation/views/empty_page.dart';
import 'package:pman/src/presentation/views/loading_page.dart';

import '../../utils/common/app_common.dart';

class ApprovePage extends StatelessWidget {
  ApprovePage({super.key});

  final _aC = Get.find<ApproveController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorAccent,
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 60,
        backgroundColor: colorAccent,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        title: AppText.labelW600(
          "approval",
          16,
          Colors.white,
        ).tr(),
        actions: [
          Obx(() {
            if (_aC.isViewTable.value) {
              return IconButton(
                onPressed: _aC.onChangeView,
                icon: const Icon(
                  Icons.list_rounded,
                ),
              );
            }
            return IconButton(
              onPressed: _aC.onChangeView,
              icon: const Icon(
                Icons.table_chart_rounded,
              ),
            );
          })
        ],
      ),
      body: Stack(
        children: [
          Obx(() {
            if (_aC.isLoading.value) {
              return const LoadingPage();
            }
            if (_aC.approvals.isEmpty) {
              return const Center(child: EmptyPage());
            }
            if (_aC.isViewTable.value) {
              return ApproveTablePage();
            }

            return ApproveListPage();
          }),
          Obx(() {
            if (_aC.isSubLoading.value) {
              return Container(
                color: Colors.transparent,
                width: double.infinity,
                height: AppConstanta.sizes.height,
                child: const LoadingPage(),
              );
            }

            return const SizedBox();
          })
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          if (_aC.isSubLoading.value) {
            return const SizedBox();
          }
          return Container(
            color: Colors.white,
            padding:
                const EdgeInsets.only(bottom: 6, top: 6, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => SizedBox(
                      height: 40,
                      child: DropdownSearch<ProjectLeaderObjData>(
                        popupProps: PopupProps.menu(
                          fit: FlexFit.loose,
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              hintText: "Cari berdasarkan nama",
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                wordSpacing: 4,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        selectedItem: _aC.selectedLeader.value,
                        asyncItems: (String filter) => _aC.getLeaders(),
                        itemAsString: (ProjectLeaderObjData u) =>
                            u.txtPicStreamName,
                        onChanged: _aC.onChangeLead,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              wordSpacing: 4,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: _aC.approveTask,
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(colorAccent)),
                  child: AppText.labelW600(
                    "APPROVE",
                    12,
                    Colors.white,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
