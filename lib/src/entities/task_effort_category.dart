import 'dart:convert';

import 'package:equatable/equatable.dart';

TaskEffortCategoryEntity taskEffortCategoryEntityFromJson(String str) =>
    TaskEffortCategoryEntity.fromJson(json.decode(str));

String taskEffortCategoryEntityToJson(TaskEffortCategoryEntity data) =>
    json.encode(data.toJson());

class TaskEffortCategoryEntity extends Equatable {
  final bool bitSuccess;
  final TaskEffortCategoryObjData objData;
  final TaskEffortCategoryObjRequest objRequest;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  const TaskEffortCategoryEntity({
    required this.bitSuccess,
    required this.objData,
    required this.objRequest,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  TaskEffortCategoryEntity copyWith({
    bool? bitSuccess,
    TaskEffortCategoryObjData? objData,
    TaskEffortCategoryObjRequest? objRequest,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      TaskEffortCategoryEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        objRequest: objRequest ?? this.objRequest,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory TaskEffortCategoryEntity.fromJson(Map<String, dynamic> json) =>
      TaskEffortCategoryEntity(
        bitSuccess: json["bitSuccess"],
        objData: TaskEffortCategoryObjData.fromJson(json["objData"]),
        objRequest: TaskEffortCategoryObjRequest(
            txtDeptCode: "", txtMilestone: "", intLeadtime: 0),
        txtMessage: json["txtMessage"],
        txtStackTrace: json["txtStackTrace"],
        txtGuid: json["txtGUID"],
      );

  Map<String, dynamic> toJson() => {
        "bitSuccess": bitSuccess,
        "objData": objData.toJson(),
        "objRequest": objRequest.toJson(),
        "txtMessage": txtMessage,
        "txtStackTrace": txtStackTrace,
        "txtGUID": txtGuid,
      };

  @override
  List<Object?> get props => [bitSuccess, objData, txtMessage, txtGuid];
}

class TaskEffortCategoryObjRequest {
  final String txtDeptCode;
  final String txtMilestone;
  final int intLeadtime;

  TaskEffortCategoryObjRequest({
    required this.txtDeptCode,
    required this.txtMilestone,
    required this.intLeadtime,
  });

  TaskEffortCategoryObjRequest copyWith({
    String? txtDeptCode,
    String? txtMilestone,
    int? intLeadtime,
  }) =>
      TaskEffortCategoryObjRequest(
        txtDeptCode: txtDeptCode ?? this.txtDeptCode,
        txtMilestone: txtMilestone ?? this.txtMilestone,
        intLeadtime: intLeadtime ?? this.intLeadtime,
      );

  factory TaskEffortCategoryObjRequest.fromJson(Map<String, dynamic> json) =>
      TaskEffortCategoryObjRequest(
        txtDeptCode: json["txtDeptCode"],
        txtMilestone: json["txtMilestone"],
        intLeadtime: json["intLeadtime"],
      );

  Map<String, dynamic> toJson() => {
        "txtDeptCode": txtDeptCode,
        "txtMilestone": txtMilestone,
        "intLeadtime": intLeadtime,
      };
}

class TaskEffortCategoryObjData extends Equatable {
  final int intLeadtime;
  final String txtDeptCode;
  final String txtTaskEffortCategory;

  const TaskEffortCategoryObjData({
    required this.intLeadtime,
    required this.txtDeptCode,
    required this.txtTaskEffortCategory,
  });

  TaskEffortCategoryObjData copyWith({
    int? intLeadtime,
    String? txtDeptCode,
    String? txtTaskEffortCategory,
  }) =>
      TaskEffortCategoryObjData(
        intLeadtime: intLeadtime ?? this.intLeadtime,
        txtDeptCode: txtDeptCode ?? this.txtDeptCode,
        txtTaskEffortCategory:
            txtTaskEffortCategory ?? this.txtTaskEffortCategory,
      );

  factory TaskEffortCategoryObjData.fromJson(Map<String, dynamic> json) =>
      TaskEffortCategoryObjData(
        intLeadtime: json["intLeadtime"],
        txtDeptCode: json["txtDeptCode"],
        txtTaskEffortCategory: json["txtTaskEffortCategory"],
      );

  Map<String, dynamic> toJson() => {
        "intLeadtime": intLeadtime,
        "txtDeptCode": txtDeptCode,
        "txtTaskEffortCategory": txtTaskEffortCategory,
      };

  @override
  List<Object?> get props => [intLeadtime, txtDeptCode, txtTaskEffortCategory];
}
