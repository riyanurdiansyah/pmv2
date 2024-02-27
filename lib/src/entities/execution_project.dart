import 'dart:convert';

import 'package:equatable/equatable.dart';

ExecutionProjectEntity executionProjectEntityFromJson(String str) =>
    ExecutionProjectEntity.fromJson(json.decode(str));

String executionProjectEntityToJson(ExecutionProjectEntity data) =>
    json.encode(data.toJson());

class ExecutionProjectEntity extends Equatable {
  final bool bitSuccess;
  final List<ExecutionProjectObjData> objData;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  const ExecutionProjectEntity({
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  ExecutionProjectEntity copyWith({
    bool? bitSuccess,
    List<ExecutionProjectObjData>? objData,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      ExecutionProjectEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory ExecutionProjectEntity.fromJson(Map<String, dynamic> json) =>
      ExecutionProjectEntity(
        bitSuccess: json["bitSuccess"],
        objData: List<ExecutionProjectObjData>.from(
            json["objData"].map((x) => ExecutionProjectObjData.fromJson(x))),
        txtMessage: json["txtMessage"],
        txtStackTrace: json["txtStackTrace"],
        txtGuid: json["txtGUID"],
      );

  factory ExecutionProjectEntity.emptyObject() => const ExecutionProjectEntity(
        bitSuccess: false,
        objData: [],
        txtMessage: "",
        txtStackTrace: "",
        txtGuid: "",
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

class ExecutionProjectObjData {
  final int intYear;
  final int intProjectExecutionId;
  final String txtDocReference;
  final int intProjectPlanId;
  final int intProjectId;
  final String txtProjectCode;
  final String txtProjectName;
  final String txtProjectObjective;
  final String txtResourceCode;
  final String txtResourceName;
  final String txtMilestone;
  final String dtmPlanStartDate;
  final String dtmPlanEndDate;
  final String txtProgressStatus;
  final int intProgressValue;
  final String txtProgressValue;
  final int page;

  ExecutionProjectObjData({
    required this.intYear,
    required this.intProjectExecutionId,
    required this.txtDocReference,
    required this.intProjectPlanId,
    required this.intProjectId,
    required this.txtProjectCode,
    required this.txtProjectName,
    required this.txtProjectObjective,
    required this.txtResourceCode,
    required this.txtResourceName,
    required this.txtMilestone,
    required this.dtmPlanStartDate,
    required this.dtmPlanEndDate,
    required this.txtProgressStatus,
    required this.intProgressValue,
    required this.txtProgressValue,
    required this.page,
  });

  ExecutionProjectObjData copyWith({
    int? intYear,
    int? intProjectExecutionId,
    String? txtDocReference,
    int? intProjectPlanId,
    int? intProjectId,
    String? txtProjectCode,
    String? txtProjectName,
    String? txtProjectObjective,
    String? txtResourceCode,
    String? txtResourceName,
    String? txtMilestone,
    String? dtmPlanStartDate,
    String? dtmPlanEndDate,
    String? txtProgressStatus,
    int? intProgressValue,
    String? txtProgressValue,
    int? page,
  }) =>
      ExecutionProjectObjData(
        intYear: intYear ?? this.intYear,
        intProjectExecutionId:
            intProjectExecutionId ?? this.intProjectExecutionId,
        txtDocReference: txtDocReference ?? this.txtDocReference,
        intProjectPlanId: intProjectPlanId ?? this.intProjectPlanId,
        intProjectId: intProjectId ?? this.intProjectId,
        txtProjectCode: txtProjectCode ?? this.txtProjectCode,
        txtProjectName: txtProjectName ?? this.txtProjectName,
        txtProjectObjective: txtProjectObjective ?? this.txtProjectObjective,
        txtResourceCode: txtResourceCode ?? this.txtResourceCode,
        txtResourceName: txtResourceName ?? this.txtResourceName,
        txtMilestone: txtMilestone ?? this.txtMilestone,
        dtmPlanStartDate: dtmPlanStartDate ?? this.dtmPlanStartDate,
        dtmPlanEndDate: dtmPlanEndDate ?? this.dtmPlanEndDate,
        txtProgressStatus: txtProgressStatus ?? this.txtProgressStatus,
        intProgressValue: intProgressValue ?? this.intProgressValue,
        txtProgressValue: txtProgressValue ?? this.txtProgressValue,
        page: page ?? this.page,
      );

  factory ExecutionProjectObjData.fromJson(Map<String, dynamic> json) =>
      ExecutionProjectObjData(
        intYear: json["intYear"],
        intProjectExecutionId: json["intProjectExecutionID"],
        txtDocReference: json["txtDocReference"],
        intProjectPlanId: json["intProjectPlanID"],
        intProjectId: json["intProjectID"],
        txtProjectCode: json["txtProjectCode"],
        txtProjectName: json["txtProjectName"],
        txtProjectObjective: json["txtProjectObjective"],
        txtResourceCode: json["txtResourceCode"],
        txtResourceName: json["txtResourceName"],
        txtMilestone: json["txtMilestone"],
        dtmPlanStartDate: json["dtmPlanStartDate"],
        dtmPlanEndDate: json["dtmPlanEndDate"],
        txtProgressStatus: json["txtProgressStatus"],
        intProgressValue: json["intProgressValue"],
        txtProgressValue: json["txtProgressValue"],
        page: 0,
      );

  Map<String, dynamic> toJson() => {
        "intYear": intYear,
        "intProjectExecutionID": intProjectExecutionId,
        "txtDocReference": txtDocReference,
        "intProjectPlanID": intProjectPlanId,
        "intProjectID": intProjectId,
        "txtProjectCode": txtProjectCode,
        "txtProjectName": txtProjectName,
        "txtProjectObjective": txtProjectObjective,
        "txtResourceCode": txtResourceCode,
        "txtResourceName": txtResourceName,
        "txtMilestone": txtMilestone,
        "dtmPlanStartDate": dtmPlanStartDate,
        "dtmPlanEndDate": dtmPlanEndDate,
        "txtProgressStatus": txtProgressStatus,
        "intProgressValue": intProgressValue,
        "txtProgressValue": txtProgressValue,
      };
}
