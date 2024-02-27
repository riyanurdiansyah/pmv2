import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pman/src/entities/approval.dart';
import 'package:pman/src/presentation/controllers/approve_controller.dart';
import 'package:pman/src/presentation/views/widgets/approve_card.dart';

import '../../utils/common/app_common.dart';
import 'empty_page.dart';
import 'loading_page.dart';

class ApproveListPage extends StatelessWidget {
  ApproveListPage({super.key});

  final _aC = Get.find<ApproveController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: double.infinity,
          child: SizedBox(
            height: 40,
            child: TextFormField(
              enableInteractiveSelection: false,
              controller: _aC.tcSearch,
              onChanged: _aC.onSearchApproval,
              // style: TextStyle(
              //   height: 1.4,
              // ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: "search",
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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
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
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Obx(() {
                List<ApprovalObjData> approvals = [];
                if (_aC.isSearch.value) {
                  approvals = _aC.approvalsSearch.toList();
                } else {
                  approvals = _aC.approvals.toList();
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
                    (index) => ApproveCard(
                      data: approvals[index],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(
          height: AppConstanta.sizes.defaultPadding,
        ),
      ],
    );
  }
}
