import 'dart:convert';

import 'package:equatable/equatable.dart';

ApprovalCategoryEntity approvalCategoryEntityFromJson(String str) =>
    ApprovalCategoryEntity.fromJson(json.decode(str));

String approvalCategoryEntityToJson(ApprovalCategoryEntity data) =>
    json.encode(data.toJson());

List<ApprovalCategoryObjData> approvalCategoryObjDatas(String str) =>
    List<ApprovalCategoryObjData>.from(
        json.decode(str).map((x) => ApprovalCategoryObjData.fromJson(x)));

class ApprovalCategoryEntity {
  final bool bitSuccess;
  final List<ApprovalCategoryObjData> objData;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  ApprovalCategoryEntity({
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  ApprovalCategoryEntity copyWith({
    bool? bitSuccess,
    List<ApprovalCategoryObjData>? objData,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      ApprovalCategoryEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory ApprovalCategoryEntity.fromJson(Map<String, dynamic> json) =>
      ApprovalCategoryEntity(
        bitSuccess: json["bitSuccess"],
        objData: List<ApprovalCategoryObjData>.from(
            json["objData"].map((x) => ApprovalCategoryObjData.fromJson(x))),
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

class ApprovalCategoryObjData extends Equatable {
  final int intDetailId;
  final String txtDescription;
  final String txtMilestone;

  const ApprovalCategoryObjData({
    required this.intDetailId,
    required this.txtDescription,
    required this.txtMilestone,
  });

  ApprovalCategoryObjData copyWith({
    int? intDetailId,
    String? txtDescription,
    String? txtMilestone,
  }) =>
      ApprovalCategoryObjData(
        intDetailId: intDetailId ?? this.intDetailId,
        txtDescription: txtDescription ?? this.txtDescription,
        txtMilestone: txtMilestone ?? this.txtMilestone,
      );

  factory ApprovalCategoryObjData.fromJson(Map<String, dynamic> json) =>
      ApprovalCategoryObjData(
        intDetailId: json["intDetailID"],
        txtDescription: json["txtDescription"],
        txtMilestone: json["txtMilestone"],
      );

  factory ApprovalCategoryObjData.emptyObject() =>
      const ApprovalCategoryObjData(
        intDetailId: 0,
        txtDescription: "",
        txtMilestone: "",
      );

  Map<String, dynamic> toJson() => {
        "intDetailID": intDetailId,
        "txtDescription": txtDescription,
        "txtMilestone": txtMilestone,
      };

  @override
  List<Object?> get props => [intDetailId, txtDescription, txtMilestone];
}
