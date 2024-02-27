import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pman/src/presentation/controllers/approve_controller.dart';
import 'package:pman/src/presentation/views/widgets/pagination.dart';

import '../../entities/approval.dart';
import '../../entities/approval_category.dart';
import '../../entities/dev_source.dart';
import '../../utils/common/app_common.dart';
import 'empty_page.dart';
import 'loading_page.dart';

class ApproveTablePage extends StatelessWidget {
  ApproveTablePage({super.key});

  final _aC = Get.find<ApproveController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 6,
          ),
          Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Scrollbar(
                  interactive: true,
                  trackVisibility: true,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey.shade600,
                        padding: const EdgeInsets.only(left: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 250,
                              child: AppText.labelBold(
                                "Project Name",
                                14,
                                Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.white,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 250,
                              child: AppText.labelBold(
                                "Task Description",
                                14,
                                Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.white,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 180,
                              child: AppText.labelBold(
                                "Resource Code",
                                14,
                                Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.white,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 180,
                              child: AppText.labelBold(
                                "Resource Name",
                                14,
                                Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.white,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 180,
                              child: AppText.labelBold(
                                "Milestone",
                                14,
                                Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.white,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 250,
                              child: AppText.labelBold(
                                "Task Category",
                                14,
                                Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.white,
                            ),
                            Container(
                              width: 100,
                              alignment: Alignment.center,
                              height: 50,
                              child: AppText.labelBold(
                                "Lead Time",
                                14,
                                Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.white,
                            ),
                            Container(
                              width: 180,
                              alignment: Alignment.center,
                              height: 50,
                              child: AppText.labelBold(
                                "Task Effort",
                                14,
                                Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.white,
                            ),
                            Container(
                              width: 180,
                              alignment: Alignment.center,
                              height: 50,
                              child: AppText.labelBold(
                                "Plan StartDate",
                                14,
                                Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.white,
                            ),
                            Container(
                              width: 180,
                              alignment: Alignment.center,
                              height: 50,
                              child: AppText.labelBold(
                                "Plan EndDate",
                                14,
                                Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        RxList<ApprovalObjData> approvals =
                            <ApprovalObjData>[].obs;
                        if (_aC.isSearch.value) {
                          approvals.value = _aC.approvalsSearch
                              .where((e) => e.page == _aC.page.value)
                              .toList();
                        } else {
                          approvals.value = _aC.approvals
                              .where((e) => e.page == _aC.page.value)
                              .toList();
                        }

                        if (_aC.isLoading.value) {
                          return const LoadingPage();
                        }

                        if (approvals.isEmpty) {
                          return const EmptyPage();
                        }

                        return Column(
                          children: List.generate(
                            approvals.length,
                            (index) => Container(
                              color: index.isEven
                                  ? Colors.white
                                  : Colors.grey.shade300,
                              padding: const EdgeInsets.only(left: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 70,
                                    width: 250,
                                    child: AppText.labelW500(
                                      approvals[index].txtProjectName,
                                      12,
                                      Colors.black,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 70,
                                    width: 250,
                                    child: AppText.labelW500(
                                      approvals[index].txtTaskDescription,
                                      12,
                                      Colors.black,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 70,
                                    width: 180,
                                    child: SizedBox(
                                      height: 50,
                                      width: 160,
                                      child: DropdownSearch<DevSourceObjData>(
                                        popupProps: PopupProps.modalBottomSheet(
                                          itemBuilder: (context, data, _) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: AppConstanta
                                                    .sizes.defaultPadding,
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  _aC.onChangeDevTable(
                                                      data, index);
                                                },
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AppText.labelW600(
                                                          data.txtResourceName,
                                                          12.5,
                                                          Colors.black87,
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        AppText.labelW600(
                                                          data.txtNik,
                                                          10.5,
                                                          Colors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Obx(
                                                      () => Radio(
                                                        activeColor:
                                                            colorPrimaryDark,
                                                        value: data.txtNik,
                                                        groupValue: approvals[
                                                                index]
                                                            .txtResourceCode,
                                                        onChanged: (val) => _aC
                                                            .onChangeDevTable(
                                                                data, index),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          showSelectedItems: false,
                                          disabledItemFn: (data) =>
                                              approvals[index]
                                                  .txtResourceName ==
                                              _aC.selectedApproval.value
                                                  .txtResourceName,
                                          showSearchBox: true,
                                          fit: FlexFit.loose,
                                          searchFieldProps: TextFieldProps(
                                            padding: EdgeInsets.only(
                                                top: 25,
                                                left: AppConstanta
                                                    .sizes.defaultPadding,
                                                right: AppConstanta
                                                    .sizes.defaultPadding),
                                            decoration:
                                                textFieldApprovalDecoration(
                                              fontSize: 12,
                                              hintText:
                                                  "Cari berdasarkan nama...",
                                            ),
                                          ),
                                        ),
                                        dropdownBuilder: (context, _) =>
                                            const SizedBox(),
                                        dropdownButtonProps:
                                            DropdownButtonProps(
                                          icon: AppText.labelW500(
                                            approvals[index].txtResourceCode,
                                            12.5,
                                            Colors.black,
                                          ),
                                        ),
                                        asyncItems: (String filter) =>
                                            _aC.getDevSourceByTeamName(_aC
                                                .selectedApproval
                                                .value
                                                .txtTeamSquads),
                                        itemAsString: (DevSourceObjData u) =>
                                            u.txtResourceName,
                                        onChanged: (objData) => _aC
                                            .onChangeDevTable(objData, index),
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              textFieldApprovalDecoration(
                                            fontSize: 12,
                                            hintText: approvals[index]
                                                .txtResourceCode,
                                            prefix: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  bottomLeft:
                                                      Radius.circular(4),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.search_rounded,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 70,
                                    width: 180,
                                    child: AppText.labelW500(
                                      approvals[index].txtResourceName,
                                      12,
                                      Colors.black,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 70,
                                    width: 180,
                                    child: AppText.labelW500(
                                      approvals[index].txtMilestone,
                                      12,
                                      Colors.black,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 70,
                                    width: 250,
                                    child: SizedBox(
                                      width: 220,
                                      height: 50,
                                      child: DropdownSearch<
                                          ApprovalCategoryObjData>(
                                        popupProps: PopupProps.modalBottomSheet(
                                          itemBuilder: (context, data, _) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: AppConstanta
                                                    .sizes.defaultPadding,
                                              ),
                                              child: InkWell(
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AppText.labelW600(
                                                          data.txtDescription,
                                                          12.5,
                                                          Colors.black87,
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        AppText.labelW600(
                                                          data.txtMilestone,
                                                          10.5,
                                                          _aC.seletedCategoryLOV.value
                                                                      .intDetailId ==
                                                                  data
                                                                      .intDetailId
                                                              ? Colors
                                                                  .grey.shade400
                                                              : Colors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Obx(
                                                      () => Radio(
                                                        activeColor:
                                                            colorPrimaryDark,
                                                        value: data.intDetailId,
                                                        groupValue: _aC
                                                            .seletedCategoryLOV
                                                            .value
                                                            .intDetailId,
                                                        onChanged: (val) => _aC
                                                            .onChangeCategoryLOVTable(
                                                                data, index),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          showSelectedItems: false,
                                          disabledItemFn: (data) =>
                                              data.intDetailId ==
                                              _aC.seletedCategoryLOV.value
                                                  .intDetailId,
                                          showSearchBox: true,
                                          fit: FlexFit.loose,
                                          searchFieldProps: TextFieldProps(
                                            padding: EdgeInsets.only(
                                                top: 25,
                                                left: AppConstanta
                                                    .sizes.defaultPadding,
                                                right: AppConstanta
                                                    .sizes.defaultPadding),
                                            decoration:
                                                textFieldApprovalDecoration(
                                              fontSize: 12,
                                              hintText:
                                                  "Cari berdasarkan nama...",
                                            ),
                                          ),
                                        ),
                                        dropdownBuilder: (context, _) =>
                                            const SizedBox(),
                                        dropdownButtonProps:
                                            DropdownButtonProps(
                                          icon: SizedBox(
                                            width: 160,
                                            child: approvals[index]
                                                        .txtCategory
                                                        .length >
                                                    20
                                                ? FittedBox(
                                                    child: AppText.labelW500(
                                                      approvals[index]
                                                          .txtCategory,
                                                      11.5,
                                                      Colors.black,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                : AppText.labelW500(
                                                    approvals[index]
                                                        .txtCategory,
                                                    12,
                                                    Colors.black,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                          ),
                                        ),
                                        asyncItems: (String filter) =>
                                            _aC.getAppCategoryLOV(
                                                approvals[index].txtMilestone),
                                        itemAsString:
                                            (ApprovalCategoryObjData u) =>
                                                u.txtDescription,
                                        onChanged: (catData) =>
                                            _aC.onChangeCategoryLOVTable(
                                                catData, index),
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              textFieldApprovalDecoration(
                                            fontSize: 12,
                                            hintText:
                                                "Cari berdasarkan nama...",
                                            prefix: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  bottomLeft:
                                                      Radius.circular(4),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.search_rounded,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: 100,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    alignment: Alignment.center,
                                    height: 70,
                                    child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: TextFormField(
                                        enableInteractiveSelection: false,
                                        controller: _aC.tcLeadTimeList[index],
                                        textInputAction: TextInputAction.done,
                                        textAlign: TextAlign.end,
                                        cursorColor: Colors.black,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: textFieldApprovalDecoration(
                                            fontSize: 11.5,
                                            hintText: "",
                                            radius: 4),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(3)
                                        ],
                                        onEditingComplete: () {
                                          FocusScopeNode currentFocus =
                                              FocusScope.of(context);
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                          _aC.onCompleteEditLeadTable(index);
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: 180,
                                    alignment: Alignment.center,
                                    height: 70,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: Center(
                                        child: AppText.labelW500(
                                          approvals[index].txtCategoryType,
                                          12,
                                          Colors.black,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: 180,
                                    alignment: Alignment.center,
                                    height: 70,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: InkWell(
                                      onTap: () => _aC.onPickDateTable(index),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade400,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: AppText.labelW500(
                                          DateFormat("dd/MM/yyyy").format(
                                              DateTime.parse(approvals[index]
                                                  .dtmPlanStartDate)),
                                          14,
                                          Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: 180,
                                    alignment: Alignment.center,
                                    height: 70,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade400,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: AppText.labelW500(
                                        DateFormat("dd/MM/yyyy").format(
                                            DateTime.parse(approvals[index]
                                                .dtmPlanEndDate)),
                                        14,
                                        Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Obx(() {
                List<ApprovalObjData> approvals = [];
                if (_aC.isSearch.value) {
                  approvals = _aC.approvalsSearch
                      .where((e) => e.page == _aC.page.value)
                      .toList();
                } else {
                  approvals = _aC.approvals
                      .where((e) => e.page == _aC.page.value)
                      .toList();
                }

                if (_aC.isLoading.value) {
                  return const LoadingPage();
                }

                if (approvals.isEmpty) {
                  return const SizedBox();
                }

                return Column(
                  children: List.generate(
                    approvals.length + 1,
                    (index) => Container(
                      height: index == 0 ? 50 : 70,
                      width: 50,
                      color: index == 0
                          ? Colors.grey.shade300
                          : index.isOdd
                              ? Colors.white
                              : Colors.grey.shade300,
                      child: Checkbox(
                        activeColor: colorPrimaryDark,
                        value: index == 0
                            ? _aC.selectedProjectIDs.length == approvals.length
                            : _aC.selectedProjectIDs.contains(
                                approvals[index - 1].intProjectTaskId),
                        onChanged: (val) {
                          if (index == 0) {
                            if (_aC.selectedProjectIDs.length !=
                                approvals.length) {
                              for (int i = 0; i < approvals.length; i++) {
                                if (!_aC.selectedProjectIDs
                                    .contains(approvals[i].intProjectTaskId)) {
                                  _aC.selectedProjectIDs
                                      .add(approvals[i].intProjectTaskId);
                                }
                              }
                            } else {
                              _aC.selectedProjectIDs.clear();
                            }
                          } else {
                            if (_aC.selectedProjectIDs.contains(
                                approvals[index - 1].intProjectTaskId)) {
                              _aC.selectedProjectIDs.removeWhere((e) =>
                                  e == approvals[index - 1].intProjectTaskId);
                            } else {
                              _aC.selectedProjectIDs
                                  .add(approvals[index - 1].intProjectTaskId);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppConstanta.sizes.defaultPadding, horizontal: 6),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      enableInteractiveSelection: false,
                      controller: _aC.tcSearch,
                      onChanged: _aC.onSearchApproval,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "cari...",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          wordSpacing: 4,
                        ),
                        suffixIcon: Obx(() {
                          if (!_aC.isSearch.value) {
                            return const SizedBox();
                          }
                          return IconButton(
                            onPressed: () {
                              _aC.tcSearch.clear();
                              _aC.onSearchApproval("");
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                            ),
                          );
                        }),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Obx(
                  () {
                    List<ApprovalObjData> approvals = [];
                    if (_aC.isSearch.value) {
                      approvals = _aC.approvalsSearch;
                    } else {
                      approvals = _aC.approvals;
                    }
                    return Pagination(
                      currentPage: _aC.page.value,
                      totalPage: (approvals.length / 5).ceil() == 0
                          ? 1
                          : (approvals.length / 5).ceil(),
                      onPageChanged: _aC.onChangePage,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
