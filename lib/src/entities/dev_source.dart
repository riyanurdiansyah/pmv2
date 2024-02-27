import 'dart:convert';

import 'package:equatable/equatable.dart';

DevSourceEntity devSourceEntityFromJson(String str) =>
    DevSourceEntity.fromJson(json.decode(str));

String devSourceEntityToJson(DevSourceEntity data) =>
    json.encode(data.toJson());

List<DevSourceObjData> devSourceObjDatas(String str) =>
    List<DevSourceObjData>.from(
        json.decode(str).map((x) => DevSourceObjData.fromJson(x)));

class DevSourceEntity extends Equatable {
  final bool bitSuccess;
  final List<DevSourceObjData> objData;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  const DevSourceEntity({
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  DevSourceEntity copyWith({
    bool? bitSuccess,
    List<DevSourceObjData>? objData,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      DevSourceEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory DevSourceEntity.fromJson(Map<String, dynamic> json) =>
      DevSourceEntity(
        bitSuccess: json["bitSuccess"],
        objData: List<DevSourceObjData>.from(
            json["objData"].map((x) => DevSourceObjData.fromJson(x))),
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

  @override
  List<Object?> get props =>
      [bitSuccess, objData, txtMessage, txtStackTrace, txtGuid];
}

class DevSourceObjData extends Equatable {
  final String txtNik;
  final String txtResourceName;
  final int intMappingResourceDetailId;
  final int intMappingResourceHeaderId;
  final String txtGuid;
  final bool bitActive;
  final String txtInsertedBy;
  final String txtUpdatedBy;
  final String dtmInsertedDate;
  final String dtmUpdatedDate;
  final String txtDepartmentCode;

  const DevSourceObjData({
    required this.txtNik,
    required this.txtResourceName,
    required this.intMappingResourceDetailId,
    required this.intMappingResourceHeaderId,
    required this.txtGuid,
    required this.bitActive,
    required this.txtInsertedBy,
    required this.txtUpdatedBy,
    required this.dtmInsertedDate,
    required this.dtmUpdatedDate,
    required this.txtDepartmentCode,
  });

  DevSourceObjData copyWith({
    String? txtNik,
    String? txtResourceName,
    int? intMappingResourceDetailId,
    int? intMappingResourceHeaderId,
    String? txtGuid,
    bool? bitActive,
    String? txtInsertedBy,
    String? txtUpdatedBy,
    String? dtmInsertedDate,
    String? dtmUpdatedDate,
    String? txtDepartmentCode,
  }) =>
      DevSourceObjData(
        txtNik: txtNik ?? this.txtNik,
        txtResourceName: txtResourceName ?? this.txtResourceName,
        intMappingResourceDetailId:
            intMappingResourceDetailId ?? this.intMappingResourceDetailId,
        intMappingResourceHeaderId:
            intMappingResourceHeaderId ?? this.intMappingResourceHeaderId,
        txtGuid: txtGuid ?? this.txtGuid,
        bitActive: bitActive ?? this.bitActive,
        txtInsertedBy: txtInsertedBy ?? this.txtInsertedBy,
        txtUpdatedBy: txtUpdatedBy ?? this.txtUpdatedBy,
        dtmInsertedDate: dtmInsertedDate ?? this.dtmInsertedDate,
        dtmUpdatedDate: dtmUpdatedDate ?? this.dtmUpdatedDate,
        txtDepartmentCode: txtDepartmentCode ?? this.txtDepartmentCode,
      );

  factory DevSourceObjData.fromJson(Map<String, dynamic> json) =>
      DevSourceObjData(
        txtNik: json["txtNIK"],
        txtResourceName: json["txtResourceName"],
        intMappingResourceDetailId: json["intMappingResource_DetailID"],
        intMappingResourceHeaderId: json["intMappingResource_HeaderID"],
        txtGuid: json["txtGUID"],
        bitActive: json["bitActive"],
        txtInsertedBy: json["txtInsertedBy"],
        txtUpdatedBy: json["txtUpdatedBy"],
        dtmInsertedDate: json["dtmInsertedDate"],
        dtmUpdatedDate: json["dtmUpdatedDate"],
        txtDepartmentCode: json["txtDepartmentCode"],
      );

  Map<String, dynamic> toJson() => {
        "txtNIK": txtNik,
        "txtResourceName": txtResourceName,
        "intMappingResource_DetailID": intMappingResourceDetailId,
        "intMappingResource_HeaderID": intMappingResourceHeaderId,
        "txtGUID": txtGuid,
        "bitActive": bitActive,
        "txtInsertedBy": txtInsertedBy,
        "txtUpdatedBy": txtUpdatedBy,
        "dtmInsertedDate": dtmInsertedDate,
        "dtmUpdatedDate": dtmUpdatedDate,
        "txtDepartmentCode": txtDepartmentCode,
      };

  @override
  List<Object?> get props => [
        txtNik,
        txtResourceName,
        intMappingResourceDetailId,
        intMappingResourceHeaderId,
        txtGuid,
        bitActive,
        txtInsertedBy,
        txtUpdatedBy,
        dtmInsertedDate,
        dtmUpdatedDate,
        txtDepartmentCode
      ];
}
