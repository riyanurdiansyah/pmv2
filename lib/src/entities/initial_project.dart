// To parse this JSON data, do
//
//     final initialProjectEntity = initialProjectEntityFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

InitialProjectEntity initialProjectEntityFromJson(String str) =>
    InitialProjectEntity.fromJson(json.decode(str));

String initialProjectEntityToJson(InitialProjectEntity data) =>
    json.encode(data.toJson());

class InitialProjectEntity extends Equatable {
  final bool bitSuccess;
  final List<InitialProjectObjData> objData;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  const InitialProjectEntity({
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  InitialProjectEntity copyWith({
    bool? bitSuccess,
    List<InitialProjectObjData>? objData,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      InitialProjectEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory InitialProjectEntity.fromJson(Map<String, dynamic> json) =>
      InitialProjectEntity(
        bitSuccess: json["bitSuccess"],
        objData: List<InitialProjectObjData>.from(
            json["objData"].map((x) => InitialProjectObjData.fromJson(x))),
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

  factory InitialProjectEntity.emptyObject() => const InitialProjectEntity(
        bitSuccess: false,
        objData: [],
        txtMessage: "",
        txtStackTrace: "",
        txtGuid: "",
      );

  @override
  List<Object?> get props =>
      [bitSuccess, objData, txtMessage, txtStackTrace, txtGuid];
}

class InitialProjectObjData extends Equatable {
  final int intYear;
  final int intProjectPlanId;
  final int intProjectId;
  final int intProjectExecutionId;
  final String txtProjectCode;
  final String txtProjectName;
  final String txtResourceCode;
  final String txtResourceName;
  final String txtDocReference;
  final String txtProjectObjective;
  final int intProgressValue;
  final String txtProgressValue;
  final String txtMilestone;
  final String txtProgressStatus;

  const InitialProjectObjData({
    required this.intYear,
    required this.intProjectPlanId,
    required this.intProjectId,
    required this.intProjectExecutionId,
    required this.txtProjectCode,
    required this.txtProjectName,
    required this.txtResourceCode,
    required this.txtResourceName,
    required this.txtDocReference,
    required this.txtProjectObjective,
    required this.intProgressValue,
    required this.txtProgressValue,
    required this.txtMilestone,
    required this.txtProgressStatus,
  });

  InitialProjectObjData copyWith({
    int? intYear,
    int? intProjectPlanId,
    int? intProjectId,
    int? intProjectExecutionId,
    String? txtProjectCode,
    String? txtProjectName,
    String? txtResourceCode,
    String? txtResourceName,
    String? txtDocReference,
    String? txtProjectObjective,
    int? intProgressValue,
    String? txtProgressValue,
    String? txtMilestone,
    String? txtProgressStatus,
  }) =>
      InitialProjectObjData(
        intYear: intYear ?? this.intYear,
        intProjectPlanId: intProjectPlanId ?? this.intProjectPlanId,
        intProjectId: intProjectId ?? this.intProjectId,
        intProjectExecutionId:
            intProjectExecutionId ?? this.intProjectExecutionId,
        txtProjectCode: txtProjectCode ?? this.txtProjectCode,
        txtProjectName: txtProjectName ?? this.txtProjectName,
        txtResourceCode: txtResourceCode ?? this.txtResourceCode,
        txtResourceName: txtResourceName ?? this.txtResourceName,
        txtDocReference: txtDocReference ?? this.txtDocReference,
        txtProjectObjective: txtProjectObjective ?? this.txtProjectObjective,
        intProgressValue: intProgressValue ?? this.intProgressValue,
        txtProgressValue: txtProgressValue ?? this.txtProgressValue,
        txtMilestone: txtMilestone ?? this.txtMilestone,
        txtProgressStatus: txtProgressStatus ?? this.txtProgressStatus,
      );

  factory InitialProjectObjData.fromJson(Map<String, dynamic> json) =>
      InitialProjectObjData(
        intYear: json["intYear"],
        intProjectPlanId: json["intProjectPlanID"],
        intProjectId: json["intProjectID"],
        intProjectExecutionId: json["intProjectExecutionID"],
        txtProjectCode: json["txtProjectCode"],
        txtProjectName: json["txtProjectName"],
        txtResourceCode: json["txtResourceCode"],
        txtResourceName: json["txtResourceName"],
        txtDocReference: json["txtDocReference"],
        txtProjectObjective: json["txtProjectObjective"],
        intProgressValue: json["intProgressValue"],
        txtProgressValue: json["txtProgressValue"],
        txtMilestone: json["txtMilestone"],
        txtProgressStatus: json["txtProgressStatus"],
      );

  Map<String, dynamic> toJson() => {
        "intYear": intYear,
        "intProjectPlanID": intProjectPlanId,
        "intProjectID": intProjectId,
        "intProjectExecutionID": intProjectExecutionId,
        "txtProjectCode": txtProjectCode,
        "txtProjectName": txtProjectName,
        "txtResourceCode": txtResourceCode,
        "txtResourceName": txtResourceName,
        "txtDocReference": txtDocReference,
        "txtProjectObjective": txtProjectObjective,
        "intProgressValue": intProgressValue,
        "txtProgressValue": txtProgressValue,
        "txtMilestone": txtMilestone,
        "txtProgressStatus": txtProgressStatus,
      };

  @override
  List<Object?> get props => [
        intYear,
        intProjectPlanId,
        intProjectId,
        intProjectExecutionId,
        txtProjectCode,
        txtProjectName,
        txtResourceCode,
        txtResourceName,
        txtDocReference,
        txtProjectObjective,
        intProgressValue,
        txtProgressValue,
        txtMilestone,
        txtProgressStatus,
      ];
}
