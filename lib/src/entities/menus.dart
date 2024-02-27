import 'dart:convert';

import 'package:equatable/equatable.dart';

List<MenuEntity> menuEntityFromJson(String str) =>
    List<MenuEntity>.from(json.decode(str).map((x) => MenuEntity.fromJson(x)));

String menuEntityToJson(List<MenuEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuEntity extends Equatable {
  final int intMenuId;
  final String txtMenuCode;
  final String txtMenuName;
  final String txtDescription;
  final String txtLink;
  final bool bitActive;
  final String txtIcon;
  final String txtGuid;
  final List<MenuEntity> itemList;

  const MenuEntity({
    required this.intMenuId,
    required this.txtMenuCode,
    required this.txtMenuName,
    required this.txtDescription,
    required this.txtLink,
    required this.bitActive,
    required this.txtIcon,
    required this.txtGuid,
    required this.itemList,
  });

  MenuEntity copyWith({
    int? intMenuId,
    String? txtMenuCode,
    String? txtMenuName,
    String? txtDescription,
    String? txtLink,
    bool? bitActive,
    String? txtIcon,
    String? txtGuid,
    List<MenuEntity>? itemList,
  }) =>
      MenuEntity(
        intMenuId: intMenuId ?? this.intMenuId,
        txtMenuCode: txtMenuCode ?? this.txtMenuCode,
        txtMenuName: txtMenuName ?? this.txtMenuName,
        txtDescription: txtDescription ?? this.txtDescription,
        txtLink: txtLink ?? this.txtLink,
        bitActive: bitActive ?? this.bitActive,
        txtIcon: txtIcon ?? this.txtIcon,
        txtGuid: txtGuid ?? this.txtGuid,
        itemList: itemList ?? this.itemList,
      );

  factory MenuEntity.fromJson(Map<String, dynamic> json) => MenuEntity(
        intMenuId: json["intMenuID"],
        txtMenuCode: json["txtMenuCode"] ?? "",
        txtMenuName: json["txtMenuName"] ?? "",
        txtDescription: json["txtDescription"] ?? "",
        txtLink: json["txtLink"] ?? "/",
        bitActive: json["bitActive"] ?? "",
        txtIcon: json["txtIcon"] ?? "",
        txtGuid: json["txtGUID"] ?? "",
        itemList: json["itemList"] == null
            ? []
            : List<MenuEntity>.from(
                json["itemList"].map(
                  (x) => MenuEntity.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "intMenuID": intMenuId,
        "txtMenuCode": txtMenuCode,
        "txtMenuName": txtMenuName,
        "txtDescription": txtDescription,
        "txtLink": txtLink,
        "bitActive": bitActive,
        "txtIcon": txtIcon,
        "txtGUID": txtGuid,
        "itemList": List<dynamic>.from(itemList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        intMenuId,
        txtMenuCode,
        txtMenuName,
        txtDescription,
        txtLink,
        bitActive,
        txtIcon,
        txtGuid,
      ];
}
