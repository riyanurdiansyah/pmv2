import 'dart:convert';

import 'package:business_logic/business_logic.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/entities/history.dart';
import 'package:pman/src/utils/config/app_dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user.dart';
import '../../utils/config/app_router.dart';

class NotifController extends GetxController {
  late SharedPreferences prefs;
  NotifRepository notifRepository = getIt<NotifRepository>();

  final Rx<UserEntity> user = UserEntity.emptyObject().obs;

  final RxList<HistoryEntity> histories = <HistoryEntity>[].obs;

  @override
  void onInit() async {
    await setup();
    await getHistories();
    super.onInit();
  }

  Future setup() async {
    prefs = await SharedPreferences.getInstance();

    final userString = prefs.getString("user");
    final userRole = prefs.getString("role");
    if (userString != null && userRole != null) {
      user.value = UserEntity.fromJson(json.decode(userString));
    }
  }

  Future getHistories() async {}

  Future updateHistories(HistoryEntity history) async {}

  Future deleteHistories(int id) async {}

  String getInitials(String fullname) {
    return notifRepository.getInitials(fullname);
  }

  String getTimeAgo(DateTime date) {
    return notifRepository.getTimeAgo(date);
  }

  void onSelectNotif(int index) {
    final payload = json.decode(histories[index].payload);
    if (payload["page"] != null) {
      final page = json.decode(payload["page"]) as Map<String, dynamic>;
      final param = page["parameter"];
      navigatorKey.currentContext!.goNamed(
        page["route"],
        extra: {
          "search": param == null ? null : param["search"],
          "txtPicStreamName": param["txtPicStreamName"],
          "txtPicStreamNik": param["txtPicStreamNik"],
        },
      );
    }

    if (histories[index].isRead == 0) {
      histories[index] = histories[index].copyWith(
        isRead: 1,
      );
      updateHistories(histories[index]);
      getHistories();
    }
  }

  void onDeleteNotif(int index) {
    deleteHistories(index);
    getHistories();
  }
}
