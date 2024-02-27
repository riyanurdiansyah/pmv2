// To parse this JSON data, do
//
//     final historyEntity = historyEntityFromJson(jsonString);

import 'dart:convert';

List<HistoryEntity> historiesEntityFromJson(String str) =>
    List<HistoryEntity>.from(
        json.decode(str).map((x) => HistoryEntity.fromJson(x)));

HistoryEntity historyEntityFromJson(String str) =>
    HistoryEntity.fromJson(json.decode(str));

String historyEntityToJson(HistoryEntity data) => json.encode(data.toJson());

class HistoryEntity {
  final int id;
  final int isRead;
  final String title;
  final String body;
  final String payload;
  final String created;

  HistoryEntity({
    required this.id,
    required this.isRead,
    required this.title,
    required this.body,
    required this.payload,
    required this.created,
  });

  HistoryEntity copyWith({
    int? id,
    int? isRead,
    String? senderId,
    String? senderName,
    String? receiverId,
    String? title,
    String? body,
    String? payload,
    String? created,
  }) =>
      HistoryEntity(
        id: id ?? this.id,
        isRead: isRead ?? this.isRead,
        title: title ?? this.title,
        body: body ?? this.body,
        payload: payload ?? this.payload,
        created: created ?? this.created,
      );

  factory HistoryEntity.fromJson(Map<String, dynamic> json) => HistoryEntity(
        id: json["id"] ?? 0,
        isRead: json["isRead"] ?? 0,
        title: json["title"] ?? "",
        body: json["body"] ?? "",
        payload: json["payload"] ?? "",
        created: json["created"] ?? DateTime.now().toIso8601String(),
      );

  Map<String, dynamic> toJson() => {
        "isRead": isRead,
        "title": title,
        "body": body,
        "payload": payload,
        "created": created,
      };
}
