import 'dart:convert';

import 'package:equatable/equatable.dart';

ResourceEntity resourceEntityFromJson(String str) =>
    ResourceEntity.fromJson(json.decode(str));

String resourceEntityToJson(ResourceEntity data) => json.encode(data.toJson());

class ResourceEntity {
  final bool bitSuccess;
  final List<ResourceObjData> objData;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  ResourceEntity({
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  ResourceEntity copyWith({
    bool? bitSuccess,
    List<ResourceObjData>? objData,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      ResourceEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory ResourceEntity.fromJson(Map<String, dynamic> json) => ResourceEntity(
        bitSuccess: json["bitSuccess"],
        objData: List<ResourceObjData>.from(
            json["objData"].map((x) => ResourceObjData.fromJson(x))),
        txtMessage: json["txtMessage"],
        txtStackTrace: json["txtStackTrace"],
        txtGuid: json["txtGUID"],
      );

  Map<String, dynamic> toJson() => {
        "bitSuccess": bitSuccess,
        "objData": List<dynamic>.from(objData.map((x) => x.toJson())),
        "txtMessage": txtMessage,
        "txtStackTrace": txtStackTrace,
        "txtGUID": txtGuid,
      };
}

class ResourceObjData extends Equatable {
  final String txtNik;
  final String txtNickName;
  final String txtResourceName;
  final String txtJobTitle;
  final String txtDepartmentCode;
  final String txtDepartmentName;

  const ResourceObjData({
    required this.txtNik,
    required this.txtNickName,
    required this.txtResourceName,
    required this.txtJobTitle,
    required this.txtDepartmentCode,
    required this.txtDepartmentName,
  });

  ResourceObjData copyWith({
    String? txtNik,
    String? txtNickName,
    String? txtResourceName,
    String? txtJobTitle,
    String? txtDepartmentCode,
    String? txtDepartmentName,
  }) =>
      ResourceObjData(
        txtNik: txtNik ?? this.txtNik,
        txtNickName: txtNickName ?? this.txtNickName,
        txtResourceName: txtResourceName ?? this.txtResourceName,
        txtJobTitle: txtJobTitle ?? this.txtJobTitle,
        txtDepartmentCode: txtDepartmentCode ?? this.txtDepartmentCode,
        txtDepartmentName: txtDepartmentName ?? this.txtDepartmentName,
      );

  factory ResourceObjData.fromJson(Map<String, dynamic> json) =>
      ResourceObjData(
        txtNik: json["txtNIK"].toString(),
        txtNickName: json["txtNickName"],
        txtResourceName: json["txtResourceName"],
        txtJobTitle: json["txtJobTitle"],
        txtDepartmentCode: json["txtDepartmentCode"],
        txtDepartmentName: json["txtDepartmentName"],
      );

  factory ResourceObjData.emptyObject() => const ResourceObjData(
        txtNik: "",
        txtNickName: "",
        txtResourceName: "",
        txtJobTitle: "",
        txtDepartmentCode: "",
        txtDepartmentName: "",
      );

  Map<String, dynamic> toJson() => {
        "txtNIK": txtNik,
        "txtNickName": txtNickName,
        "txtResourceName": txtResourceName,
        "txtJobTitle": txtJobTitle,
        "txtDepartmentCode": txtDepartmentCode,
        "txtDepartmentName": txtDepartmentName,
      };

  @override
  List<Object?> get props => [
        txtNik,
        txtNickName,
        txtResourceName,
        txtJobTitle,
        txtDepartmentCode,
        txtDepartmentName,
      ];
}
