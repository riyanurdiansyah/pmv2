// To parse this JSON data, do
//
//     final executionProjectDetailEntity = executionProjectDetailEntityFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ExecutionProjectDetailEntity executionProjectDetailEntityFromJson(String str) =>
    ExecutionProjectDetailEntity.fromJson(json.decode(str));

String executionProjectDetailEntityToJson(ExecutionProjectDetailEntity data) =>
    json.encode(data.toJson());

class ExecutionProjectDetailEntity extends Equatable {
  final bool bitSuccess;
  final ExecutionProjectDetailObjData objData;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  const ExecutionProjectDetailEntity({
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  ExecutionProjectDetailEntity copyWith({
    bool? bitSuccess,
    ExecutionProjectDetailObjData? objData,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      ExecutionProjectDetailEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory ExecutionProjectDetailEntity.fromJson(Map<String, dynamic> json) =>
      ExecutionProjectDetailEntity(
        bitSuccess: json["bitSuccess"],
        objData: ExecutionProjectDetailObjData.fromJson(json["objData"]),
        txtMessage: json["txtMessage"],
        txtStackTrace: json["txtStackTrace"],
        txtGuid: json["txtGUID"],
      );

  Map<String, dynamic> toJson() => {
        "bitSuccess": bitSuccess,
        "objData": objData.toJson(),
        "txtMessage": txtMessage,
        "txtStackTrace": txtStackTrace,
        "txtGUID": txtGuid,
      };

  factory ExecutionProjectDetailEntity.emptyObject() =>
      ExecutionProjectDetailEntity(
        bitSuccess: false,
        objData: ExecutionProjectDetailObjData.emptyObject(),
        txtMessage: "",
        txtStackTrace: "",
        txtGuid: "",
      );

  @override
  List<Object?> get props =>
      [bitSuccess, objData, txtMessage, txtStackTrace, txtGuid];
}

class ExecutionProjectDetailObjData extends Equatable {
  final int intProjectObjectiveHeaderId;
  final int intYear;
  final int intDivisionId;
  final String txtDepartmentCode;
  final int intProjectPlanHeaderId;
  final String txtPicResourceCode;
  final String txtPicResourceName;
  final String txtProjectObjectiveCode;
  final String txtProjectObjectiveDesc;
  final double decWeight;
  final int intFileAttachHeaderId;
  final bool bitActive;
  final String txtInsertedBy;
  final dynamic dtmInsertedDate;
  final String txtUpdatedBy;
  final dynamic dtmUpdatedDate;
  final List<TrProjectObjectiveMilestoneDetail>
      trProjectObjectiveMilestoneDetail;
  final String txtDivisionCode;
  final String txtDivisionName;
  final String txtDepartmentName;
  final String txtOrganizationCode;
  final int intProjectId;
  final String txtProjectCode;
  final String txtProjectName;

  const ExecutionProjectDetailObjData({
    required this.intProjectObjectiveHeaderId,
    required this.intYear,
    required this.intDivisionId,
    required this.txtDepartmentCode,
    required this.intProjectPlanHeaderId,
    required this.txtPicResourceCode,
    required this.txtPicResourceName,
    required this.txtProjectObjectiveCode,
    required this.txtProjectObjectiveDesc,
    required this.decWeight,
    required this.intFileAttachHeaderId,
    required this.bitActive,
    required this.txtInsertedBy,
    required this.dtmInsertedDate,
    required this.txtUpdatedBy,
    required this.dtmUpdatedDate,
    required this.trProjectObjectiveMilestoneDetail,
    required this.txtDivisionCode,
    required this.txtDivisionName,
    required this.txtDepartmentName,
    required this.txtOrganizationCode,
    required this.intProjectId,
    required this.txtProjectCode,
    required this.txtProjectName,
  });

  ExecutionProjectDetailObjData copyWith({
    int? intProjectObjectiveHeaderId,
    int? intYear,
    int? intDivisionId,
    String? txtDepartmentCode,
    int? intProjectPlanHeaderId,
    String? txtPicResourceCode,
    String? txtPicResourceName,
    String? txtProjectObjectiveCode,
    String? txtProjectObjectiveDesc,
    double? decWeight,
    int? intFileAttachHeaderId,
    bool? bitActive,
    String? txtInsertedBy,
    dynamic dtmInsertedDate,
    String? txtUpdatedBy,
    dynamic dtmUpdatedDate,
    List<TrProjectObjectiveMilestoneDetail>? trProjectObjectiveMilestoneDetail,
    String? txtDivisionCode,
    String? txtDivisionName,
    String? txtDepartmentName,
    String? txtOrganizationCode,
    int? intProjectId,
    String? txtProjectCode,
    String? txtProjectName,
  }) =>
      ExecutionProjectDetailObjData(
        intProjectObjectiveHeaderId:
            intProjectObjectiveHeaderId ?? this.intProjectObjectiveHeaderId,
        intYear: intYear ?? this.intYear,
        intDivisionId: intDivisionId ?? this.intDivisionId,
        txtDepartmentCode: txtDepartmentCode ?? this.txtDepartmentCode,
        intProjectPlanHeaderId:
            intProjectPlanHeaderId ?? this.intProjectPlanHeaderId,
        txtPicResourceCode: txtPicResourceCode ?? this.txtPicResourceCode,
        txtPicResourceName: txtPicResourceName ?? this.txtPicResourceName,
        txtProjectObjectiveCode:
            txtProjectObjectiveCode ?? this.txtProjectObjectiveCode,
        txtProjectObjectiveDesc:
            txtProjectObjectiveDesc ?? this.txtProjectObjectiveDesc,
        decWeight: decWeight ?? this.decWeight,
        intFileAttachHeaderId:
            intFileAttachHeaderId ?? this.intFileAttachHeaderId,
        bitActive: bitActive ?? this.bitActive,
        txtInsertedBy: txtInsertedBy ?? this.txtInsertedBy,
        dtmInsertedDate: dtmInsertedDate ?? this.dtmInsertedDate,
        txtUpdatedBy: txtUpdatedBy ?? this.txtUpdatedBy,
        dtmUpdatedDate: dtmUpdatedDate ?? this.dtmUpdatedDate,
        trProjectObjectiveMilestoneDetail: trProjectObjectiveMilestoneDetail ??
            this.trProjectObjectiveMilestoneDetail,
        txtDivisionCode: txtDivisionCode ?? this.txtDivisionCode,
        txtDivisionName: txtDivisionName ?? this.txtDivisionName,
        txtDepartmentName: txtDepartmentName ?? this.txtDepartmentName,
        txtOrganizationCode: txtOrganizationCode ?? this.txtOrganizationCode,
        intProjectId: intProjectId ?? this.intProjectId,
        txtProjectCode: txtProjectCode ?? this.txtProjectCode,
        txtProjectName: txtProjectName ?? this.txtProjectName,
      );

  factory ExecutionProjectDetailObjData.fromJson(Map<String, dynamic> json) =>
      ExecutionProjectDetailObjData(
        intProjectObjectiveHeaderId: json["intProjectObjective_HeaderID"],
        intYear: json["intYear"],
        intDivisionId: json["intDivisionID"],
        txtDepartmentCode: json["txtDepartmentCode"],
        intProjectPlanHeaderId: json["intProjectPlan_HeaderID"],
        txtPicResourceCode: json["txtPICResourceCode"],
        txtPicResourceName: json["txtPICResourceName"],
        txtProjectObjectiveCode: json["txtProjectObjectiveCode"],
        txtProjectObjectiveDesc: json["txtProjectObjectiveDesc"],
        decWeight: json["decWeight"],
        intFileAttachHeaderId: json["intFileAttach_HeaderID"],
        bitActive: json["bitActive"],
        txtInsertedBy: json["txtInsertedBy"],
        dtmInsertedDate: json["dtmInsertedDate"],
        txtUpdatedBy: json["txtUpdatedBy"],
        dtmUpdatedDate: json["dtmUpdatedDate"],
        trProjectObjectiveMilestoneDetail:
            List<TrProjectObjectiveMilestoneDetail>.from(
                json["TrProjectObjective_MilestoneDetail"]
                    .map((x) => TrProjectObjectiveMilestoneDetail.fromJson(x))),
        txtDivisionCode: json["txtDivisionCode"],
        txtDivisionName: json["txtDivisionName"],
        txtDepartmentName: json["txtDepartmentName"],
        txtOrganizationCode: json["txtOrganizationCode"],
        intProjectId: json["intProjectID"],
        txtProjectCode: json["txtProjectCode"],
        txtProjectName: json["txtProjectName"],
      );

  factory ExecutionProjectDetailObjData.emptyObject() =>
      const ExecutionProjectDetailObjData(
        intProjectObjectiveHeaderId: 0,
        intYear: 0,
        intDivisionId: 0,
        txtDepartmentCode: "",
        intProjectPlanHeaderId: 0,
        txtPicResourceCode: "",
        txtPicResourceName: "",
        txtProjectObjectiveCode: "",
        txtProjectObjectiveDesc: "",
        decWeight: 0,
        intFileAttachHeaderId: 0,
        bitActive: false,
        txtInsertedBy: "",
        dtmInsertedDate: null,
        txtUpdatedBy: "",
        dtmUpdatedDate: null,
        trProjectObjectiveMilestoneDetail: [],
        txtDivisionCode: "",
        txtDivisionName: "",
        txtDepartmentName: "",
        txtOrganizationCode: "",
        intProjectId: 0,
        txtProjectCode: "",
        txtProjectName: "",
      );

  Map<String, dynamic> toJson() => {
        "intProjectObjective_HeaderID": intProjectObjectiveHeaderId,
        "intYear": intYear,
        "intDivisionID": intDivisionId,
        "txtDepartmentCode": txtDepartmentCode,
        "intProjectPlan_HeaderID": intProjectPlanHeaderId,
        "txtPICResourceCode": txtPicResourceCode,
        "txtPICResourceName": txtPicResourceName,
        "txtProjectObjectiveCode": txtProjectObjectiveCode,
        "txtProjectObjectiveDesc": txtProjectObjectiveDesc,
        "decWeight": decWeight,
        "intFileAttach_HeaderID": intFileAttachHeaderId,
        "bitActive": bitActive,
        "txtInsertedBy": txtInsertedBy,
        "dtmInsertedDate": dtmInsertedDate,
        "txtUpdatedBy": txtUpdatedBy,
        "dtmUpdatedDate": dtmUpdatedDate,
        "TrProjectObjective_MilestoneDetail": List<Map<String, dynamic>>.from(
            trProjectObjectiveMilestoneDetail.map((x) => x.toJson())),
        "txtDivisionCode": txtDivisionCode,
        "txtDivisionName": txtDivisionName,
        "txtDepartmentName": txtDepartmentName,
        "txtOrganizationCode": txtOrganizationCode,
        "intProjectID": intProjectId,
        "txtProjectCode": txtProjectCode,
        "txtProjectName": txtProjectName,
      };

  @override
  List<Object?> get props => [
        intProjectObjectiveHeaderId,
        intYear,
        intDivisionId,
        txtDepartmentCode,
        intProjectPlanHeaderId,
        txtPicResourceCode,
        txtPicResourceName,
        txtProjectObjectiveCode,
        txtProjectObjectiveDesc,
        decWeight,
        intFileAttachHeaderId,
        bitActive,
        txtInsertedBy,
        dtmUpdatedDate,
        trProjectObjectiveMilestoneDetail,
        txtDivisionCode,
        txtDivisionName,
        txtDepartmentName,
        txtOrganizationCode,
        intProjectId,
        txtProjectCode,
        txtProjectName,
      ];
}

class TrProjectObjectiveMilestoneDetail {
  final int intProjectObjectiveMilestoneDetailId;
  final int intProjectObjectiveHeaderId;
  final String txtMilestone;
  final int intLeadTime;
  final dynamic dtmPlanStartDate;
  final dynamic dtmPlanEndDate;
  final String txtProjectLeader;
  final double decWeight;
  final bool bitActive;
  final String txtInsertedBy;
  final dynamic dtmInsertedDate;
  final String txtUpdatedBy;
  final dynamic dtmUpdatedDate;
  final dynamic trProjectObjectiveHeader;
  final List<TrProjectObjectiveMilestoneTaskDetail>
      trProjectObjectiveMilestoneTaskDetail;
  final String txtProjectLeaderName;
  final int intProjectPlanHeaderId;
  final String txtGUID;

  TrProjectObjectiveMilestoneDetail({
    required this.intProjectObjectiveMilestoneDetailId,
    required this.intProjectObjectiveHeaderId,
    required this.txtMilestone,
    required this.intLeadTime,
    required this.dtmPlanStartDate,
    required this.dtmPlanEndDate,
    required this.txtProjectLeader,
    required this.decWeight,
    required this.bitActive,
    required this.txtInsertedBy,
    required this.dtmInsertedDate,
    required this.txtUpdatedBy,
    required this.dtmUpdatedDate,
    required this.trProjectObjectiveHeader,
    required this.trProjectObjectiveMilestoneTaskDetail,
    required this.txtProjectLeaderName,
    required this.intProjectPlanHeaderId,
    required this.txtGUID,
  });

  TrProjectObjectiveMilestoneDetail copyWith({
    int? intProjectObjectiveMilestoneDetailId,
    int? intProjectObjectiveHeaderId,
    String? txtMilestone,
    int? intLeadTime,
    dynamic dtmPlanStartDate,
    dynamic dtmPlanEndDate,
    String? txtProjectLeader,
    double? decWeight,
    bool? bitActive,
    String? txtInsertedBy,
    dynamic dtmInsertedDate,
    String? txtUpdatedBy,
    dynamic dtmUpdatedDate,
    dynamic trProjectObjectiveHeader,
    List<TrProjectObjectiveMilestoneTaskDetail>?
        trProjectObjectiveMilestoneTaskDetail,
    String? txtProjectLeaderName,
    int? intProjectPlanHeaderId,
    String? txtGUID,
  }) =>
      TrProjectObjectiveMilestoneDetail(
        intProjectObjectiveMilestoneDetailId:
            intProjectObjectiveMilestoneDetailId ??
                this.intProjectObjectiveMilestoneDetailId,
        intProjectObjectiveHeaderId:
            intProjectObjectiveHeaderId ?? this.intProjectObjectiveHeaderId,
        txtMilestone: txtMilestone ?? this.txtMilestone,
        intLeadTime: intLeadTime ?? this.intLeadTime,
        dtmPlanStartDate: dtmPlanStartDate ?? this.dtmPlanStartDate,
        dtmPlanEndDate: dtmPlanEndDate ?? this.dtmPlanEndDate,
        txtProjectLeader: txtProjectLeader ?? this.txtProjectLeader,
        decWeight: decWeight ?? this.decWeight,
        bitActive: bitActive ?? this.bitActive,
        txtInsertedBy: txtInsertedBy ?? this.txtInsertedBy,
        dtmInsertedDate: dtmInsertedDate ?? this.dtmInsertedDate,
        txtUpdatedBy: txtUpdatedBy ?? this.txtUpdatedBy,
        dtmUpdatedDate: dtmUpdatedDate ?? this.dtmUpdatedDate,
        trProjectObjectiveHeader:
            trProjectObjectiveHeader ?? this.trProjectObjectiveHeader,
        trProjectObjectiveMilestoneTaskDetail:
            trProjectObjectiveMilestoneTaskDetail ??
                this.trProjectObjectiveMilestoneTaskDetail,
        txtProjectLeaderName: txtProjectLeaderName ?? this.txtProjectLeaderName,
        intProjectPlanHeaderId:
            intProjectPlanHeaderId ?? this.intProjectPlanHeaderId,
        txtGUID: txtGUID ?? this.txtGUID,
      );

  factory TrProjectObjectiveMilestoneDetail.fromJson(
          Map<String, dynamic> json) =>
      TrProjectObjectiveMilestoneDetail(
        intProjectObjectiveMilestoneDetailId:
            json["intProjectObjective_MilestoneDetailID"],
        intProjectObjectiveHeaderId: json["intProjectObjective_HeaderID"],
        txtMilestone: json["txtMilestone"],
        intLeadTime: json["intLeadTime"],
        dtmPlanStartDate: json["dtmPlanStartDate"],
        dtmPlanEndDate: json["dtmPlanEndDate"],
        txtProjectLeader: json["txtProjectLeader"],
        decWeight: json["decWeight"],
        bitActive: json["bitActive"],
        txtInsertedBy: json["txtInsertedBy"],
        dtmInsertedDate: json["dtmInsertedDate"],
        txtUpdatedBy: json["txtUpdatedBy"],
        dtmUpdatedDate: json["dtmUpdatedDate"],
        trProjectObjectiveHeader: json["TrProjectObjective_Header"],
        trProjectObjectiveMilestoneTaskDetail:
            List<TrProjectObjectiveMilestoneTaskDetail>.from(
                json["TrProjectObjective_MilestoneTaskDetail"].map(
                    (x) => TrProjectObjectiveMilestoneTaskDetail.fromJson(x))),
        txtProjectLeaderName: json["txtProjectLeaderName"],
        intProjectPlanHeaderId: json["intProjectPlan_HeaderID"],
        txtGUID: json["txtGUID"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "intProjectObjective_MilestoneDetailID":
            intProjectObjectiveMilestoneDetailId,
        "intProjectObjective_HeaderID": intProjectObjectiveHeaderId,
        "txtMilestone": txtMilestone,
        "intLeadTime": intLeadTime,
        "dtmPlanStartDate": dtmPlanStartDate,
        "dtmPlanEndDate": dtmPlanEndDate,
        "txtProjectLeader": txtProjectLeader,
        "decWeight": decWeight,
        "bitActive": bitActive,
        "txtInsertedBy": txtInsertedBy,
        "dtmInsertedDate": dtmInsertedDate,
        "txtUpdatedBy": txtUpdatedBy,
        "dtmUpdatedDate": dtmUpdatedDate,
        "TrProjectObjective_Header": trProjectObjectiveHeader,
        "TrProjectObjective_MilestoneTaskDetail":
            List<Map<String, dynamic>>.from(
                trProjectObjectiveMilestoneTaskDetail.map((x) => x.toJson())),
        "txtProjectLeaderName": txtProjectLeaderName,
        "intProjectPlan_HeaderID": intProjectPlanHeaderId,
        "txtGUID": txtGUID,
      };
}

class TrProjectObjectiveMilestoneTaskDetail extends Equatable {
  final int intProjectObjectiveMilestoneTaskDetailId;
  final int intProjectObjectiveMilestoneDetailId;
  final int intProjectTaskId;
  final String txtTaskDescription;
  final String txtCategory;
  final String txtCategoryType;
  final String txtDeptCode;
  final String txtResourceCode;
  final String txtResourceName;
  final int intLeadTime;
  final dynamic dtmPlanStartDate;
  final dynamic dtmPlanEndDate;
  final dynamic dtmActualStartDate;
  final dynamic dtmActualEndDate;
  final dynamic txtNotes;
  final bool bitApproved;
  final bool bitRejected;
  final bool bitActive;
  final dynamic txtInsertedBy;
  final dynamic dtmInsertedDate;
  final dynamic txtUpdatedBy;
  final dynamic dtmUpdatedDate;
  final dynamic trProjectObjectiveMilestoneDetail;
  final bool isEdit;
  final String idTemp;
  final String txtGUID;

  const TrProjectObjectiveMilestoneTaskDetail({
    required this.intProjectObjectiveMilestoneTaskDetailId,
    required this.intProjectObjectiveMilestoneDetailId,
    required this.intProjectTaskId,
    required this.txtTaskDescription,
    required this.txtCategory,
    required this.txtCategoryType,
    required this.txtDeptCode,
    required this.txtResourceCode,
    required this.txtResourceName,
    required this.intLeadTime,
    required this.dtmPlanStartDate,
    required this.dtmPlanEndDate,
    required this.dtmActualStartDate,
    required this.dtmActualEndDate,
    required this.txtNotes,
    required this.bitApproved,
    required this.bitRejected,
    required this.bitActive,
    required this.txtInsertedBy,
    required this.dtmInsertedDate,
    required this.txtUpdatedBy,
    required this.dtmUpdatedDate,
    required this.trProjectObjectiveMilestoneDetail,
    required this.isEdit,
    required this.idTemp,
    required this.txtGUID,
  });

  TrProjectObjectiveMilestoneTaskDetail copyWith({
    int? intProjectObjectiveMilestoneTaskDetailId,
    int? intProjectObjectiveMilestoneDetailId,
    int? intProjectTaskId,
    String? txtTaskDescription,
    String? txtCategory,
    String? txtCategoryType,
    String? txtDeptCode,
    String? txtResourceCode,
    String? txtResourceName,
    int? intLeadTime,
    dynamic dtmPlanStartDate,
    dynamic dtmPlanEndDate,
    dynamic dtmActualStartDate,
    dynamic dtmActualEndDate,
    dynamic txtNotes,
    bool? bitApproved,
    bool? bitRejected,
    bool? bitActive,
    dynamic txtInsertedBy,
    dynamic dtmInsertedDate,
    dynamic txtUpdatedBy,
    dynamic dtmUpdatedDate,
    dynamic trProjectObjectiveMilestoneDetail,
    bool? isEdit,
    String? idTemp,
    String? txtGUID,
  }) =>
      TrProjectObjectiveMilestoneTaskDetail(
        intProjectObjectiveMilestoneTaskDetailId:
            intProjectObjectiveMilestoneTaskDetailId ??
                this.intProjectObjectiveMilestoneTaskDetailId,
        intProjectObjectiveMilestoneDetailId:
            intProjectObjectiveMilestoneDetailId ??
                this.intProjectObjectiveMilestoneDetailId,
        intProjectTaskId: intProjectTaskId ?? this.intProjectTaskId,
        txtTaskDescription: txtTaskDescription ?? this.txtTaskDescription,
        txtCategory: txtCategory ?? this.txtCategory,
        txtCategoryType: txtCategoryType ?? this.txtCategoryType,
        txtDeptCode: txtDeptCode ?? this.txtDeptCode,
        txtResourceCode: txtResourceCode ?? this.txtResourceCode,
        txtResourceName: txtResourceName ?? this.txtResourceName,
        intLeadTime: intLeadTime ?? this.intLeadTime,
        dtmPlanStartDate: dtmPlanStartDate ?? this.dtmPlanStartDate,
        dtmPlanEndDate: dtmPlanEndDate ?? this.dtmPlanEndDate,
        dtmActualStartDate: dtmActualStartDate,
        dtmActualEndDate: dtmActualEndDate,
        txtNotes: txtNotes,
        bitApproved: bitApproved ?? this.bitApproved,
        bitRejected: bitRejected ?? this.bitRejected,
        bitActive: bitActive ?? this.bitActive,
        txtInsertedBy: txtInsertedBy,
        dtmInsertedDate: dtmInsertedDate,
        txtUpdatedBy: txtUpdatedBy,
        dtmUpdatedDate: dtmUpdatedDate,
        trProjectObjectiveMilestoneDetail: trProjectObjectiveMilestoneDetail,
        isEdit: isEdit ?? this.isEdit,
        idTemp: idTemp ?? this.idTemp,
        txtGUID: txtGUID ?? this.txtGUID,
      );

  factory TrProjectObjectiveMilestoneTaskDetail.fromJson(
          Map<String, dynamic> json) =>
      TrProjectObjectiveMilestoneTaskDetail(
          intProjectObjectiveMilestoneTaskDetailId:
              json["intProjectObjective_MilestoneTaskDetailID"],
          intProjectObjectiveMilestoneDetailId:
              json["intProjectObjective_MilestoneDetailID"],
          intProjectTaskId: json["intProjectTaskID"],
          txtTaskDescription: json["txtTaskDescription"],
          txtCategory: json["txtCategory"],
          txtCategoryType: json["txtCategoryType"],
          txtDeptCode: json["txtDeptCode"],
          txtResourceCode: json["txtResourceCode"],
          txtResourceName: json["txtResourceName"],
          intLeadTime: json["intLeadTime"],
          dtmPlanStartDate: json["dtmPlanStartDate"],
          dtmPlanEndDate: json["dtmPlanEndDate"],
          dtmActualStartDate: json["dtmActualStartDate"],
          dtmActualEndDate: json["dtmActualEndDate"],
          txtNotes: json["txtNotes"],
          bitApproved: json["bitApproved"],
          bitRejected: json["bitRejected"],
          bitActive: json["bitActive"],
          txtInsertedBy: json["txtInsertedBy"],
          dtmInsertedDate: json["dtmInsertedDate"],
          txtUpdatedBy: json["txtUpdatedBy"],
          dtmUpdatedDate: json["dtmUpdatedDate"],
          trProjectObjectiveMilestoneDetail:
              json["TrProjectObjective_MilestoneDetail"],
          isEdit: false,
          idTemp: "",
          txtGUID: json["txtGUID"] ?? "");

  Map<String, dynamic> toJson() => {
        "intProjectObjective_MilestoneTaskDetailID":
            intProjectObjectiveMilestoneTaskDetailId,
        "intProjectObjective_MilestoneDetailID":
            intProjectObjectiveMilestoneDetailId,
        "intProjectTaskID": intProjectTaskId,
        "txtTaskDescription": txtTaskDescription,
        "txtCategory": txtCategory,
        "txtCategoryType": txtCategoryType,
        "txtDeptCode": txtDeptCode,
        "txtResourceCode": txtResourceCode,
        "txtResourceName": txtResourceName,
        "intLeadTime": intLeadTime,
        "dtmPlanStartDate": dtmPlanStartDate,
        "dtmPlanEndDate": dtmPlanEndDate,
        "dtmActualStartDate": dtmActualStartDate,
        "dtmActualEndDate": dtmActualEndDate,
        "txtNotes": txtNotes,
        "bitApproved": bitApproved,
        "bitRejected": bitRejected,
        "bitActive": bitActive,
        "txtInsertedBy": txtInsertedBy,
        "dtmInsertedDate": dtmInsertedDate,
        "txtUpdatedBy": txtUpdatedBy,
        "dtmUpdatedDate": dtmUpdatedDate,
        "TrProjectObjective_MilestoneDetail": trProjectObjectiveMilestoneDetail,
        "txtGUID": txtGUID,
      };

  @override
  List<Object?> get props => [
        intProjectObjectiveMilestoneTaskDetailId,
        intProjectObjectiveMilestoneDetailId,
        intProjectTaskId,
        txtTaskDescription,
        txtCategory,
        txtCategoryType,
        txtDeptCode,
        txtResourceCode,
        txtResourceName,
        intLeadTime,
        dtmPlanStartDate,
        dtmPlanEndDate,
        dtmActualStartDate,
        dtmActualEndDate,
        txtNotes,
        bitApproved,
        bitRejected,
        bitActive,
        txtInsertedBy,
        dtmInsertedDate,
        txtUpdatedBy,
        dtmUpdatedDate,
        trProjectObjectiveMilestoneDetail,
        txtGUID,
      ];
}
