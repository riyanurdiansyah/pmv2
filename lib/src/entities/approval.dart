import 'dart:convert';

import 'package:equatable/equatable.dart';

ApprovalEntity approvalEntityFromJson(String str) =>
    ApprovalEntity.fromJson(json.decode(str));

String approvalEntityToJson(ApprovalEntity data) => json.encode(data.toJson());

List<ApprovalObjData> approvalObjDatas(String str) =>
    List<ApprovalObjData>.from(
        json.decode(str).map((x) => ApprovalObjData.fromJson(x)));

class ApprovalEntity {
  final bool bitSuccess;
  final List<ApprovalObjData> objData;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  ApprovalEntity({
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  ApprovalEntity copyWith({
    bool? bitSuccess,
    List<ApprovalObjData>? objData,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      ApprovalEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory ApprovalEntity.fromJson(Map<String, dynamic> json) => ApprovalEntity(
        bitSuccess: json["bitSuccess"],
        objData: List<ApprovalObjData>.from(
            json["objData"].map((x) => ApprovalObjData.fromJson(x))),
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

class ApprovalObjData extends Equatable {
  final String txtTeamSquads;
  final int intProjectId;
  final String txtProjectObjectiveDesc;
  final String txtProjectName;
  final String txtMilestone;
  final int intProjectTaskId;
  final String txtTaskDescription;
  final String txtCategory;
  final String txtCategoryType;
  final String txtDeptCode;
  final String txtDeptName;
  final String txtResourceCode;
  final String txtResourceName;
  final String dtmPlanStartDate;
  final String dtmPlanEndDate;
  final int intLeadTime;
  final int page;
  final bool isChecked;

  const ApprovalObjData({
    required this.txtTeamSquads,
    required this.intProjectId,
    required this.txtProjectObjectiveDesc,
    required this.txtProjectName,
    required this.txtMilestone,
    required this.intProjectTaskId,
    required this.txtTaskDescription,
    required this.txtCategory,
    required this.txtCategoryType,
    required this.txtDeptCode,
    required this.txtDeptName,
    required this.txtResourceCode,
    required this.txtResourceName,
    required this.dtmPlanStartDate,
    required this.dtmPlanEndDate,
    required this.intLeadTime,
    required this.page,
    required this.isChecked,
  });

  ApprovalObjData copyWith({
    String? txtTeamSquads,
    int? intProjectId,
    String? txtProjectObjectiveDesc,
    String? txtProjectName,
    String? txtMilestone,
    int? intProjectTaskId,
    String? txtTaskDescription,
    String? txtCategory,
    String? txtCategoryType,
    String? txtDeptCode,
    String? txtDeptName,
    String? txtResourceCode,
    String? txtResourceName,
    String? dtmPlanStartDate,
    String? dtmPlanEndDate,
    String? txtDepartmentCode,
    int? intLeadTime,
    int? page,
    bool? isChecked,
  }) =>
      ApprovalObjData(
        txtTeamSquads: txtTeamSquads ?? this.txtTeamSquads,
        intProjectId: intProjectId ?? this.intProjectId,
        txtProjectObjectiveDesc:
            txtProjectObjectiveDesc ?? this.txtProjectObjectiveDesc,
        txtProjectName: txtProjectName ?? this.txtProjectName,
        txtMilestone: txtMilestone ?? this.txtMilestone,
        intProjectTaskId: intProjectTaskId ?? this.intProjectTaskId,
        txtTaskDescription: txtTaskDescription ?? this.txtTaskDescription,
        txtCategory: txtCategory ?? this.txtCategory,
        txtCategoryType: txtCategoryType ?? this.txtCategoryType,
        txtDeptCode: txtDeptCode ?? this.txtDeptCode,
        txtDeptName: txtDeptName ?? this.txtDeptName,
        txtResourceCode: txtResourceCode ?? this.txtResourceCode,
        txtResourceName: txtResourceName ?? this.txtResourceName,
        dtmPlanStartDate: dtmPlanStartDate ?? this.dtmPlanStartDate,
        dtmPlanEndDate: dtmPlanEndDate ?? this.dtmPlanEndDate,
        intLeadTime: intLeadTime ?? this.intLeadTime,
        page: page ?? this.page,
        isChecked: isChecked ?? this.isChecked,
      );

  factory ApprovalObjData.fromJson(Map<String, dynamic> json) =>
      ApprovalObjData(
        txtTeamSquads: json["txtTeamSquads"],
        intProjectId: json["intProjectID"],
        txtProjectObjectiveDesc: json["txtProjectObjectiveDesc"],
        txtProjectName: json["txtProjectName"],
        txtMilestone: json["txtMilestone"],
        intProjectTaskId: json["intProjectTaskID"],
        txtTaskDescription: json["txtTaskDescription"],
        txtCategory: json["txtCategory"],
        txtCategoryType: json["txtCategoryType"],
        txtDeptCode: json["txtDeptCode"],
        txtDeptName: json["txtDeptName"],
        txtResourceCode: json["txtResourceCode"],
        txtResourceName: json["txtResourceName"],
        dtmPlanStartDate: json["dtmPlanStartDate"],
        dtmPlanEndDate: json["dtmPlanEndDate"],
        intLeadTime: json["intLeadTime"],
        page: 0,
        isChecked: false,
      );

  Map<String, dynamic> toJson() => {
        "intIndex": 0,
        "bitChecked": false,
        "bitNotifDelivered": null,
        "txtDeliveredTo": null,
        "bitNotifApproved": null,
        "txtNotifApprovedDeliveredTo": null,
        "bitNotifRejected": null,
        "txtNotifRejectedTo": null,
        "txtGUID": null,
        "bitApproved": null,
        "bitRejected": null,
        "txtApprovedBy": null,
        "txtRejectedBy": null,
        "txtAction": null,
        "txtNotes": null,
        "txtTeamSquads": txtTeamSquads,
        "intProjectID": intProjectId,
        "txtProjectObjectiveDesc": txtProjectObjectiveDesc,
        "txtProjectName": txtProjectName,
        "txtMilestone": txtMilestone,
        "intProjectTaskID": intProjectTaskId,
        "txtTaskDescription": txtTaskDescription,
        "txtCategory": txtCategory,
        "txtCategoryType": txtCategoryType,
        "txtDeptCode": txtDeptCode,
        "txtDeptName": txtDeptName,
        "txtResourceCode": txtResourceCode,
        "txtResourceName": txtResourceName,
        "dtmPlanStartDate": dtmPlanStartDate,
        "dtmPlanEndDate": dtmPlanEndDate,
        "intLeadTime": intLeadTime,
      };

  @override
  List<Object?> get props => [
        txtTeamSquads,
        intProjectId,
        txtProjectObjectiveDesc,
        txtProjectName,
        txtMilestone,
        intProjectTaskId,
        txtTaskDescription,
        txtCategory,
        txtCategoryType,
        txtDeptCode,
        txtDeptName,
        txtResourceCode,
        txtResourceName,
        dtmPlanStartDate,
        dtmPlanEndDate,
        intLeadTime,
      ];
}
