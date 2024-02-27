import 'dart:convert';

MyTaskEntity myTaskEntityFromJson(String str) =>
    MyTaskEntity.fromJson(json.decode(str));

String myTaskEntityToJson(MyTaskEntity data) => json.encode(data.toJson());

List<MyTaskObjData> myTaskObjDatas(String str) => List<MyTaskObjData>.from(
    json.decode(str).map((x) => MyTaskObjData.fromJson(x)));

class MyTaskEntity {
  final bool bitSuccess;
  final List<MyTaskObjData> objData;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  MyTaskEntity({
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  MyTaskEntity copyWith({
    bool? bitSuccess,
    List<MyTaskObjData>? objData,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      MyTaskEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory MyTaskEntity.fromJson(Map<String, dynamic> json) => MyTaskEntity(
        bitSuccess: json["bitSuccess"],
        objData: List<MyTaskObjData>.from(
            json["objData"].map((x) => MyTaskObjData.fromJson(x))),
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

class MyTaskObjData {
  final int intProjectId;
  final int intProjectPlanId;
  final int intProjectObjectiveId;
  final String txtProjectCode;
  final String txtProjectName;
  final String txtDeptCode;
  final String txtDocReference;
  final String txtProjectObjectiveDesc;
  final String txtProjectLeader;
  final String txtProjectLeaderName;
  final int intProjectTaskId;
  final String txtResourceCode;
  final String txtResourceName;
  final String txtTaskDescription;
  final String txtMilestone;
  final String dtmPlanStartDate;
  final String dtmPlanEndDate;
  final String txtStatus;
  final bool bitFinalProceed;
  final bool bitHold;
  final String txtNextStatus;
  final String txtNote;
  final int intDueProgressValue;
  final int intProgressValue;
  final String txtProgressValue;
  final int page;

  MyTaskObjData({
    required this.intProjectId,
    required this.intProjectPlanId,
    required this.intProjectObjectiveId,
    required this.txtProjectCode,
    required this.txtProjectName,
    required this.txtDeptCode,
    required this.txtDocReference,
    required this.txtProjectObjectiveDesc,
    required this.txtProjectLeader,
    required this.txtProjectLeaderName,
    required this.intProjectTaskId,
    required this.txtResourceCode,
    required this.txtResourceName,
    required this.txtTaskDescription,
    required this.txtMilestone,
    required this.dtmPlanStartDate,
    required this.dtmPlanEndDate,
    required this.txtStatus,
    required this.bitFinalProceed,
    required this.bitHold,
    required this.txtNextStatus,
    required this.txtNote,
    required this.intDueProgressValue,
    required this.intProgressValue,
    required this.txtProgressValue,
    required this.page,
  });

  MyTaskObjData copyWith({
    int? intProjectId,
    int? intProjectPlanId,
    int? intProjectObjectiveId,
    String? txtProjectCode,
    String? txtProjectName,
    String? txtDeptCode,
    String? txtDocReference,
    String? txtProjectObjectiveDesc,
    String? txtProjectLeader,
    String? txtProjectLeaderName,
    int? intProjectTaskId,
    String? txtResourceCode,
    String? txtResourceName,
    String? txtTaskDescription,
    String? txtMilestone,
    String? dtmPlanStartDate,
    String? dtmPlanEndDate,
    String? txtStatus,
    bool? bitFinalProceed,
    bool? bitHold,
    String? txtNextStatus,
    String? txtNote,
    int? intDueProgressValue,
    int? intProgressValue,
    String? txtProgressValue,
    int? page,
  }) =>
      MyTaskObjData(
        intProjectId: intProjectId ?? this.intProjectId,
        intProjectPlanId: intProjectPlanId ?? this.intProjectPlanId,
        intProjectObjectiveId:
            intProjectObjectiveId ?? this.intProjectObjectiveId,
        txtProjectCode: txtProjectCode ?? this.txtProjectCode,
        txtProjectName: txtProjectName ?? this.txtProjectName,
        txtDeptCode: txtDeptCode ?? this.txtDeptCode,
        txtDocReference: txtDocReference ?? this.txtDocReference,
        txtProjectObjectiveDesc:
            txtProjectObjectiveDesc ?? this.txtProjectObjectiveDesc,
        txtProjectLeader: txtProjectLeader ?? this.txtProjectLeader,
        txtProjectLeaderName: txtProjectLeaderName ?? this.txtProjectLeaderName,
        intProjectTaskId: intProjectTaskId ?? this.intProjectTaskId,
        txtResourceCode: txtResourceCode ?? this.txtResourceCode,
        txtResourceName: txtResourceName ?? this.txtResourceName,
        txtTaskDescription: txtTaskDescription ?? this.txtTaskDescription,
        txtMilestone: txtMilestone ?? this.txtMilestone,
        dtmPlanStartDate: dtmPlanStartDate ?? this.dtmPlanStartDate,
        dtmPlanEndDate: dtmPlanEndDate ?? this.dtmPlanEndDate,
        txtStatus: txtStatus ?? this.txtStatus,
        bitFinalProceed: bitFinalProceed ?? this.bitFinalProceed,
        bitHold: bitHold ?? this.bitHold,
        txtNextStatus: txtNextStatus ?? this.txtNextStatus,
        txtNote: txtNote ?? this.txtNote,
        intDueProgressValue: intDueProgressValue ?? this.intDueProgressValue,
        intProgressValue: intProgressValue ?? this.intProgressValue,
        txtProgressValue: txtProgressValue ?? this.txtProgressValue,
        page: page ?? this.page,
      );

  factory MyTaskObjData.fromJson(Map<String, dynamic> json) => MyTaskObjData(
        intProjectId: json["intProjectID"] ?? 0,
        intProjectPlanId: json["intProjectPlanID"] ?? 0,
        intProjectObjectiveId: json["intProjectObjectiveID"] ?? 0,
        txtProjectCode: json["txtProjectCode"] ?? "",
        txtProjectName: json["txtProjectName"] ?? "",
        txtDeptCode: json["txtDeptCode"] ?? "",
        txtDocReference: json["txtDocReference"] ?? "",
        txtProjectObjectiveDesc: json["txtProjectObjectiveDesc"] ?? "",
        txtProjectLeader: json["txtProjectLeader"] ?? "",
        txtProjectLeaderName: json["txtProjectLeaderName"] ?? "",
        intProjectTaskId: json["intProjectTaskID"] ?? "",
        txtResourceCode: json["txtResourceCode"] ?? "",
        txtResourceName: json["txtResourceName"] ?? "",
        txtTaskDescription: json["txtTaskDescription"] ?? "",
        txtMilestone: json["txtMilestone"] ?? "",
        dtmPlanStartDate: json["dtmPlanStartDate"] ?? "",
        dtmPlanEndDate: json["dtmPlanEndDate"] ?? "",
        txtStatus: json["txtStatus"] ?? "",
        bitFinalProceed: json["bitFinalProceed"] ?? false,
        bitHold: json["bitHold"] ?? false,
        txtNextStatus: json["txtNextStatus"] ?? "",
        txtNote: json["txtNote"] ?? "",
        intDueProgressValue: json["intDueProgressValue"] ?? 0,
        intProgressValue: json["intProgressValue"] ?? 0,
        txtProgressValue: json["txtProgressValue"] ?? "",
        page: 0,
      );

  Map<String, dynamic> toJson() => {
        "intProjectID": intProjectId,
        "intProjectPlanID": intProjectPlanId,
        "intProjectObjectiveID": intProjectObjectiveId,
        "txtProjectCode": txtProjectCode,
        "txtProjectName": txtProjectName,
        "txtDeptCode": txtDeptCode,
        "txtDocReference": txtDocReference,
        "txtProjectObjectiveDesc": txtProjectObjectiveDesc,
        "txtProjectLeader": txtProjectLeader,
        "txtProjectLeaderName": txtProjectLeaderName,
        "intProjectTaskID": intProjectTaskId,
        "txtResourceCode": txtResourceCode,
        "txtResourceName": txtResourceName,
        "txtTaskDescription": txtTaskDescription,
        "txtMilestone": txtMilestone,
        "dtmPlanStartDate": dtmPlanStartDate,
        "dtmPlanEndDate": dtmPlanEndDate,
        "txtStatus": txtStatus,
        "bitFinalProceed": bitFinalProceed,
        "bitHold": bitHold,
        "txtNextStatus": txtNextStatus,
        "txtNote": txtNote,
        "intDueProgressValue": intDueProgressValue,
        "intProgressValue": intProgressValue,
        "txtProgressValue": txtProgressValue,
      };
}
