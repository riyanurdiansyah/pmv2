import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pman/src/presentation/controllers/notif_controller.dart';

import '../../utils/common/app_common.dart';

class NotifPage extends StatelessWidget {
  NotifPage({
    super.key,
  });

  final _nC = Get.find<NotifController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: AppText.labelW600(
          "Notification",
          14,
          Colors.black,
        ),
      ),
      body: Obx(() {
        if (_nC.histories.isEmpty) {
          return Center(
            child: AppText.labelW500(
              "Tidak ada history",
              14,
              Colors.grey.shade500,
            ),
          );
        }
        return ListView(
          children: List.generate(
            _nC.histories.length,
            (index) => Slidable(
              key: ValueKey(index),
              endActionPane: ActionPane(
                extentRatio: 0.25,
                motion: const ScrollMotion(),
                dragDismissible: false,
                children: [
                  SlidableAction(
                    onPressed: (_) =>
                        _nC.onDeleteNotif(_nC.histories[index].id),
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ListTile(
                tileColor: _nC.histories[index].isRead == 0
                    ? colorAccent.withOpacity(0.4)
                    : Colors.white,
                onTap: () => _nC.onSelectNotif(index),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: AppConstanta.sizes.defaultPadding, vertical: 6),
                // leading: Container(
                //   alignment: Alignment.center,
                //   width: 60,
                //   height: 60,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.grey.shade100,
                //   ),
                //   child: AppText.labelBold(
                //     _nC
                //         .getInitials(json.decode(json.decode(_nC
                //             .histories[index].payload)["sender"])["senderName"])
                //         .toUpperCase(),
                //     18,
                //     Colors.grey.shade400,
                //   ),
                // ),
                title: AppText.labelW600(
                  _nC.histories[index].title,
                  14,
                  Colors.black,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.labelW500(
                        _nC.histories[index].body,
                        12.5,
                        Colors.grey,
                        maxLines: 2,
                        height: 1.25,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      AppText.labelW500(
                        _nC.getTimeAgo(
                            DateTime.parse(_nC.histories[index].created)),
                        10,
                        Colors.grey.shade500,
                        maxLines: 2,
                        height: 1.25,
                      ),
                    ],
                  ),
                ),
                trailing: _nC.histories[index].isRead == 0
                    ? Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorPrimaryDark,
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        );
      }),
    );
  }
}
