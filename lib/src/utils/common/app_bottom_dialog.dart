import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pman/src/entities/approval_category.dart';
import 'package:pman/src/entities/dev_source.dart';
import 'package:pman/src/entities/resource.dart';
import 'package:pman/src/entities/task_status.dart';
import 'package:pman/src/presentation/controllers/approve_controller.dart';
import 'package:pman/src/presentation/controllers/execution_detail_controller.dart';
import 'package:pman/src/presentation/controllers/mytask_controller.dart';

import '../../entities/execution_project_detail.dart';
import '../config/app_router.dart';
import 'app_common.dart';

class AppBottomDialog {
  static filterMyTask() {
    final mC = Get.find<MyTaskController>();
    return showModalBottomSheet(
      context: navigatorKey.currentContext!,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppConstanta.sizes.defaultPadding, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.filter_alt_rounded,
                ),
                const SizedBox(
                  width: 10,
                ),
                AppText.labelW600(
                  "Filter",
                  14,
                  Colors.black54,
                ),
                const Spacer(),
                InkWell(
                  onTap: () => context.pop(),
                  child: const Icon(
                    Icons.close_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            AppText.labelW600(
              "Resource",
              12,
              Colors.black54,
            ),
            const SizedBox(
              height: 12,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  mC.resources.length,
                  (index) => Obx(
                    () => InkWell(
                      onTap: () => mC.changeFilterResource(mC.resources[index]),
                      child: Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color:
                              mC.resourcesFilter.contains(mC.resources[index])
                                  ? colorPrimaryDark
                                  : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: AppText.labelW600(
                          mC.resources[index],
                          12,
                          mC.resourcesFilter.contains(mC.resources[index])
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppConstanta.sizes.defaultPadding,
            ),
            AppText.labelW600(
              "Status",
              12,
              Colors.black54,
            ),
            const SizedBox(
              height: 12,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  mC.statuss.length,
                  (index) => Obx(
                    () => InkWell(
                      onTap: () => mC.changeFilterStatus(mC.statuss[index]),
                      child: Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: mC.statussFilter.contains(mC.statuss[index])
                              ? colorPrimaryDark
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: AppText.labelW600(
                          mC.statuss[index],
                          12,
                          mC.statussFilter.contains(mC.statuss[index])
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AppText.labelW600(
              "Progress",
              12,
              Colors.black54,
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(
              () => RangeSlider(
                values: mC.percentFilter.value,
                labels: mC.percentLabelFilter.value,
                min: 0.0,
                max: 100.0,
                divisions: 10,
                activeColor: colorPrimaryDark,
                onChanged: (newValues) {
                  mC.percentFilter.value = newValues;
                  mC.percentLabelFilter.value =
                      RangeLabels("${newValues.start}%", "${newValues.end}%");
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton(
                      onPressed: () {
                        navigatorKey.currentContext!.pop();
                        mC.clearFilter();
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      child: AppText.labelW600(
                        "Clear Filter",
                        14,
                        colorAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: AppConstanta.sizes.defaultPadding,
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(colorPrimaryDark),
                      ),
                      onPressed: mC.applyFilter,
                      child: AppText.labelW600(
                        "Apply",
                        14,
                        Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  static detailTask() {
    final mC = Get.find<MyTaskController>();
    return showModalBottomSheet(
      context: navigatorKey.currentContext!,
      isDismissible: false,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => PopScope(
        canPop: false,
        child: DraggableScrollableSheet(
          minChildSize: 0.25,
          maxChildSize: 1.0,
          initialChildSize: 1.0,
          builder: (context, scroll) => Scaffold(
            bottomNavigationBar: Container(
              key: const Key("btnSimpanMyTask"),
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
                    backgroundColor: MaterialStateProperty.all(colorAccent)),
                onPressed: mC.updateTask,
                child: AppText.labelW600(
                  "Simpan",
                  16,
                  Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.grey.shade200,
                child: Form(
                  key: mC.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            top: AppConstanta.sizes.defaultPadding,
                            bottom: AppConstanta.sizes.defaultPadding,
                            left: 10,
                            right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                mC.clearDetailTask();
                                context.pop();
                              },
                              child: const Icon(
                                Icons.close_rounded,
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              height: AppConstanta.sizes.defaultPadding,
                            ),
                            AppText.labelBold(
                              mC.taskSelected.value.txtProjectName,
                              16,
                              Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: AppConstanta.sizes.defaultPadding,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.notes_rounded,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.labelW600(
                                  "Task Description",
                                  10,
                                  Colors.black38,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                AppText.labelW600(
                                  mC.taskSelected.value.txtTaskDescription,
                                  12,
                                  Colors.black54,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: AppConstanta.sizes.defaultPadding,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.numbers_rounded,
                                  color: Colors.black54,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.labelW600(
                                      "Resource Code",
                                      10,
                                      Colors.black38,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    AppText.labelW600(
                                      mC.taskSelected.value.txtResourceCode,
                                      12,
                                      Colors.black54,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person_rounded,
                                  color: Colors.black54,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.labelW600(
                                      "Resource Name",
                                      10,
                                      Colors.black38,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    AppText.labelW600(
                                      mC.taskSelected.value.txtResourceName,
                                      12,
                                      Colors.black54,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: AppConstanta.sizes.defaultPadding,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.bolt_horizontal_fill,
                                  color: Colors.black54,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.labelW600(
                                      "Milestone",
                                      10,
                                      Colors.black38,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    AppText.labelW600(
                                      mC.taskSelected.value.txtMilestone,
                                      12,
                                      Colors.black54,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: AppConstanta.sizes.defaultPadding,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.date_range_rounded,
                                  color: Colors.black54,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.labelW600(
                                      "Plan Start Date",
                                      10,
                                      Colors.black38,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    AppText.labelW600(
                                      DateFormat("dd/MM/yyyy").format(
                                          dotenv.get("USE_EXAMPLE") == "true"
                                              ? DateTime.now()
                                              : DateTime.parse(mC.taskSelected
                                                  .value.dtmPlanStartDate)),
                                      12,
                                      Colors.black54,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppConstanta.sizes.defaultPadding,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.date_range_rounded,
                                  color: Colors.black54,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.labelW600(
                                      "Plan End Date",
                                      10,
                                      Colors.black38,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    AppText.labelW600(
                                      DateFormat("dd/MM/yyyy").format(
                                          dotenv.get("USE_EXAMPLE") == "true"
                                              ? DateTime.now()
                                              : DateTime.parse(mC.taskSelected
                                                  .value.dtmPlanEndDate)),
                                      12,
                                      Colors.black54,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: AppConstanta.sizes.defaultPadding,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.doc_text_viewfinder,
                                  color: Colors.black54,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          AppText.labelW600(
                                            "Status",
                                            10,
                                            Colors.black38,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          AppText.labelBold(
                                            "*",
                                            18,
                                            Colors.red,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Obx(
                                        () => SizedBox(
                                          width: double.infinity,
                                          height: 40,
                                          key: const Key("ddnStatusMyTask"),
                                          child:
                                              DropdownSearch<TaskStatusObjData>(
                                            validator: (val) =>
                                                AppValidator.requiredField(
                                                    val?.name ?? ""),
                                            popupProps: PopupProps.menu(
                                              itemBuilder: (context, stats, _) {
                                                return ListTile(
                                                  key: const Key(
                                                      "txtStatusMyTask"),
                                                  title: AppText.labelW600(
                                                    stats.name,
                                                    14,
                                                    Colors.black54,
                                                  ),
                                                );
                                              },
                                              showSearchBox: false,
                                              fit: FlexFit.loose,
                                              searchFieldProps: TextFieldProps(
                                                cursorHeight: 20,
                                                decoration: InputDecoration(
                                                  hintStyle: const TextStyle(
                                                    fontSize: 14,
                                                    wordSpacing: 4,
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 0,
                                                          horizontal: AppConstanta
                                                              .sizes
                                                              .defaultPadding),
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            asyncItems: (String filter) =>
                                                mC.getTaskStatus(),
                                            selectedItem:
                                                mC.taskStatusSelected.value,
                                            itemAsString:
                                                (TaskStatusObjData u) => u.name,
                                            autoValidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            onChanged: (val) {
                                              mC.taskStatusSelected.value =
                                                  val!;
                                              mC.selectedStatusType.value =
                                                  StatusType.non;
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                hintStyle: const TextStyle(
                                                  fontSize: 14,
                                                  wordSpacing: 4,
                                                ),
                                                isCollapsed: false,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 0),
                                                border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.edit_rounded,
                                  color: Colors.black54,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          AppText.labelW600(
                                            "Note",
                                            10,
                                            Colors.black38,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          AppText.labelBold(
                                            "*",
                                            18,
                                            Colors.red,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      TextFormField(
                                        enableInteractiveSelection: false,
                                        key: const Key("tcNoteMyTask"),
                                        minLines: 3,
                                        maxLines: 5,
                                        controller: mC.tcNote,
                                        validator: (query) =>
                                            AppValidator.requiredField(query!,
                                                errorMsg:
                                                    "Note tidak boleh kosong"),
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: AppConstanta
                                                  .sizes.defaultPadding,
                                              horizontal: 12),
                                          hintStyle: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colors.white),
                                          hintText: "...",
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.red.shade300,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.red.shade300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: colorPrimary),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade400,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: AppConstanta.sizes.defaultPadding,
                                ),
                                Obx(
                                  () => Checkbox(
                                    activeColor: colorPrimaryDark,
                                    value: mC.selectedStatusType.value ==
                                        StatusType.hold,
                                    onChanged: (val) =>
                                        mC.onCheckStatus(StatusType.hold),
                                  ),
                                ),
                                AppText.labelW600(
                                  "Hold",
                                  14,
                                  Colors.black,
                                ),
                                const SizedBox(
                                  width: 80,
                                ),
                                Obx(
                                  () => SizedBox(
                                    height: 40,
                                    child: Checkbox(
                                      activeColor: colorPrimaryDark,
                                      value: mC.selectedStatusType.value ==
                                          StatusType.cancel,
                                      onChanged: (val) =>
                                          mC.onCheckStatus(StatusType.cancel),
                                    ),
                                  ),
                                ),
                                AppText.labelW600(
                                  "Cancel",
                                  14,
                                  Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static detailApproval() {
    final aC = Get.find<ApproveController>();
    return showModalBottomSheet(
      context: navigatorKey.currentContext!,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: false,
      builder: (context) => DraggableScrollableSheet(
        minChildSize: 0.25,
        maxChildSize: 1.0,
        initialChildSize: 1.0,
        builder: (context, scroll) => Scaffold(
          bottomNavigationBar: Container(
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
                  backgroundColor: MaterialStateProperty.all(colorAccent)),
              onPressed: aC.saveUpdatedSelectedApproval,
              child: AppText.labelW600(
                "Simpan",
                16,
                Colors.white,
              ),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  color: Colors.grey.shade200,
                  // padding: EdgeInsets.only(
                  //     bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            top: AppConstanta.sizes.defaultPadding,
                            bottom: AppConstanta.sizes.defaultPadding,
                            left: 10,
                            right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                aC.selectedApproval.value =
                                    approvalObjDataEmpty;
                                context.pop();
                              },
                              child: const Icon(
                                Icons.close_rounded,
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              height: AppConstanta.sizes.defaultPadding,
                            ),
                            AppText.labelBold(
                              aC.selectedApproval.value.txtProjectName,
                              16,
                              Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: AppConstanta.sizes.defaultPadding,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.notes_rounded,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.labelW600(
                                  "Task Description",
                                  10,
                                  Colors.black38,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                AppText.labelW600(
                                  aC.selectedApproval.value.txtTaskDescription,
                                  12,
                                  Colors.black54,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(
                        () => Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: AppConstanta.sizes.defaultPadding,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.numbers_rounded,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText.labelW600(
                                          "Resource Code",
                                          10,
                                          Colors.black38,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        AppText.labelW600(
                                          aC.selectedApproval.value
                                              .txtResourceCode,
                                          12,
                                          Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    height: 40,
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
                                                      groupValue: aC
                                                          .selectedApproval
                                                          .value
                                                          .txtResourceCode,
                                                      onChanged: (val) =>
                                                          aC.onChangeDev(data),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        showSelectedItems: false,
                                        disabledItemFn: (data) =>
                                            data.txtResourceName ==
                                            aC.selectedApproval.value
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
                                          decoration: InputDecoration(
                                            hintText: "Cari berdasarkan nama",
                                            hintStyle: const TextStyle(
                                              fontSize: 14,
                                              wordSpacing: 4,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 12),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: colorPrimaryDark),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: colorPrimaryDark),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: colorPrimaryDark),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: colorPrimaryDark),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: colorPrimaryDark),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      dropdownBuilder: (context, _) =>
                                          const SizedBox(),
                                      dropdownButtonProps: DropdownButtonProps(
                                        icon: AppText.labelW600(
                                          "Edit",
                                          12,
                                          Colors.blue,
                                        ),
                                      ),
                                      asyncItems: (String filter) =>
                                          aC.getDevSourceByTeamName(aC
                                              .selectedApproval
                                              .value
                                              .txtTeamSquads),
                                      itemAsString: (DevSourceObjData u) =>
                                          u.txtResourceName,
                                      onChanged: aC.onChangeDev,
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintStyle: const TextStyle(
                                            fontSize: 14,
                                            wordSpacing: 4,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person_rounded,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText.labelW600(
                                        "Resource Name",
                                        10,
                                        Colors.black38,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      AppText.labelW600(
                                        aC.selectedApproval.value
                                            .txtResourceName,
                                        12,
                                        Colors.black54,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(
                        () => Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: AppConstanta.sizes.defaultPadding,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.bolt_horizontal_fill,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText.labelW600(
                                          "Milestone",
                                          10,
                                          Colors.black38,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        AppText.labelW600(
                                          aC.selectedApproval.value
                                              .txtMilestone,
                                          12,
                                          Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    height: 40,
                                    child:
                                        DropdownSearch<ApprovalCategoryObjData>(
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
                                                        aC.seletedCategoryLOV.value
                                                                    .intDetailId ==
                                                                data.intDetailId
                                                            ? Colors
                                                                .grey.shade500
                                                            : Colors.black87,
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      AppText.labelW600(
                                                        data.txtMilestone,
                                                        10.5,
                                                        aC.seletedCategoryLOV.value
                                                                    .intDetailId ==
                                                                data.intDetailId
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
                                                      groupValue: aC
                                                          .seletedCategoryLOV
                                                          .value
                                                          .intDetailId,
                                                      onChanged: (val) => aC
                                                          .onChangeCategoryLOV(
                                                              data),
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
                                            aC.seletedCategoryLOV.value
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
                                          decoration: InputDecoration(
                                            hintText: "Cari berdasarkan nama",
                                            hintStyle: const TextStyle(
                                              fontSize: 14,
                                              wordSpacing: 4,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 12),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: colorPrimaryDark),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: colorPrimaryDark),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: colorPrimaryDark),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: colorPrimaryDark),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: colorPrimaryDark),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      dropdownBuilder: (context, _) =>
                                          const SizedBox(),
                                      dropdownButtonProps: DropdownButtonProps(
                                        icon: AppText.labelW600(
                                          "Edit",
                                          12,
                                          Colors.blue,
                                        ),
                                      ),
                                      asyncItems: (String filter) =>
                                          aC.getAppCategoryLOV(aC
                                              .selectedApproval
                                              .value
                                              .txtMilestone),
                                      itemAsString:
                                          (ApprovalCategoryObjData u) =>
                                              u.txtDescription,
                                      onChanged: aC.onChangeCategoryLOV,
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintStyle: const TextStyle(
                                            fontSize: 14,
                                            wordSpacing: 4,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppConstanta.sizes.defaultPadding,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.category,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText.labelW600(
                                          "Task Category",
                                          10,
                                          Colors.black38,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        AppText.labelW600(
                                          aC.selectedApproval.value.txtCategory,
                                          12,
                                          Colors.black54,
                                          height: 1.25,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppConstanta.sizes.defaultPadding,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.timelapse_sharp,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText.labelW600(
                                        "Lead Time",
                                        10,
                                        Colors.black38,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      SizedBox(
                                        width: 60,
                                        height: 40,
                                        child: TextFormField(
                                          enableInteractiveSelection: false,
                                          controller: aC.tcLeadTime,
                                          textInputAction: TextInputAction.done,
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
                                            aC.onCompleteEditLead();
                                          },
                                          decoration: textFieldAuthDecoration(
                                              fontSize: 10, hintText: ""),
                                        ),
                                      ),
                                      // AppText.labelW600(
                                      //   aC.selectedApproval.value.intLeadTime
                                      //       .toString(),
                                      //   12,
                                      //   Colors.black54,
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppConstanta.sizes.defaultPadding,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.explicit_rounded,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText.labelW600(
                                        "Task Effort",
                                        10,
                                        Colors.black38,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      AppText.labelW600(
                                        aC.selectedApproval.value
                                            .txtCategoryType,
                                        12,
                                        Colors.black54,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(
                        () => Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: AppConstanta.sizes.defaultPadding,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.date_range_rounded,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText.labelW600(
                                        "Plan Start Date",
                                        10,
                                        Colors.black38,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      AppText.labelW600(
                                        aC.selectedApproval.value ==
                                                approvalObjDataEmpty
                                            ? ""
                                            : DateFormat("dd/MM/yyyy").format(
                                                dotenv.get("USE_EXAMPLE") ==
                                                        "true"
                                                    ? DateTime.now()
                                                    : DateTime.parse(aC
                                                        .selectedApproval
                                                        .value
                                                        .dtmPlanStartDate)),
                                        12,
                                        Colors.black54,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: aC.onPickDate,
                                    child: AppText.labelW600(
                                      "Edit",
                                      12,
                                      Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppConstanta.sizes.defaultPadding,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.date_range_rounded,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText.labelW600(
                                        "Plan End Date",
                                        10,
                                        Colors.black38,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      AppText.labelW600(
                                        aC.selectedApproval.value ==
                                                approvalObjDataEmpty
                                            ? ""
                                            : DateFormat("dd/MM/yyyy").format(
                                                dotenv.get("USE_EXAMPLE") ==
                                                        "true"
                                                    ? DateTime.now()
                                                    : DateTime.parse(aC
                                                        .selectedApproval
                                                        .value
                                                        .dtmPlanEndDate)),
                                        12,
                                        Colors.black54,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                if (aC.isSubLoading.isFalse) {
                  return const SizedBox();
                }

                return Container(
                  width: AppConstanta.sizes.width,
                  height: AppConstanta.sizes.height,
                  color: Colors.transparent,
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorPrimaryDark,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const CupertinoActivityIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  static assignTask({TrProjectObjectiveMilestoneTaskDetail? oldData}) {
    final eC = Get.find<ExecutionProjectDetailController>();
    return showModalBottomSheet(
      context: navigatorKey.currentContext!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return PopScope(
          onPopInvoked: (didPop) {},
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.labelW600(
                    "ASSIGNMENT",
                    16,
                    Colors.black,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppText.labelW600(
                    "Task Assignment",
                    14,
                    Colors.black,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 50,
                    child: DropdownSearch<ResourceObjData>(
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
                      selectedItem: eC.selectedResource.value,
                      asyncItems: eC.getResurces,
                      itemAsString: (ResourceObjData u) => u.txtResourceName,
                      // onChanged: .onChangeLead,
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
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
