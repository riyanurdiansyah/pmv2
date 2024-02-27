import 'dart:convert';

import 'package:equatable/equatable.dart';

LogTaskStatusEntity logTaskStatusEntityFromJson(String str) =>
    LogTaskStatusEntity.fromJson(json.decode(str));

String logTaskStatusEntityToJson(LogTaskStatusEntity data) =>
    json.encode(data.toJson());

class LogTaskStatusEntity extends Equatable {
  final bool bitSuccess;
  final List<LogTaskStatusObjData> objData;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  const LogTaskStatusEntity({
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  LogTaskStatusEntity copyWith({
    bool? bitSuccess,
    List<LogTaskStatusObjData>? objData,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      LogTaskStatusEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory LogTaskStatusEntity.fromJson(Map<String, dynamic> json) =>
      LogTaskStatusEntity(
        bitSuccess: json["bitSuccess"],
        objData: List<LogTaskStatusObjData>.from(
            json["objData"].map((x) => LogTaskStatusObjData.fromJson(x))),
        txtMessage: json["txtMessage"],
        txtStackTrace: json["txtStackTrace"],
        txtGuid: json["txtGUID"],
      );

  factory LogTaskStatusEntity.emptyObject() => const LogTaskStatusEntity(
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

class LogTaskStatusObjData extends Equatable {
  final int intProjectTaskStatusId;
  final int intProjectTaskId;
  final String txtResourceCode;
  final String txtRemark;
  final String txtStatus;
  final String txtGuid;
  final double decProgressValue;
  final bool bitActive;
  final String txtTaskDescription;
  final String txtCategory;
  final DateTime dtmInsertedDate;

  const LogTaskStatusObjData({
    required this.intProjectTaskStatusId,
    required this.intProjectTaskId,
    required this.txtResourceCode,
    required this.txtRemark,
    required this.txtStatus,
    required this.txtGuid,
    required this.decProgressValue,
    required this.bitActive,
    required this.txtTaskDescription,
    required this.txtCategory,
    required this.dtmInsertedDate,
  });

  LogTaskStatusObjData copyWith({
    int? intProjectTaskStatusId,
    int? intProjectTaskId,
    String? txtResourceCode,
    String? txtRemark,
    String? txtStatus,
    String? txtGuid,
    double? decProgressValue,
    bool? bitActive,
    String? txtTaskDescription,
    String? txtCategory,
    DateTime? dtmInsertedDate,
  }) =>
      LogTaskStatusObjData(
        intProjectTaskStatusId:
            intProjectTaskStatusId ?? this.intProjectTaskStatusId,
        intProjectTaskId: intProjectTaskId ?? this.intProjectTaskId,
        txtResourceCode: txtResourceCode ?? this.txtResourceCode,
        txtRemark: txtRemark ?? this.txtRemark,
        txtStatus: txtStatus ?? this.txtStatus,
        txtGuid: txtGuid ?? this.txtGuid,
        decProgressValue: decProgressValue ?? this.decProgressValue,
        bitActive: bitActive ?? this.bitActive,
        txtTaskDescription: txtTaskDescription ?? this.txtTaskDescription,
        txtCategory: txtCategory ?? this.txtCategory,
        dtmInsertedDate: dtmInsertedDate ?? this.dtmInsertedDate,
      );

  factory LogTaskStatusObjData.fromJson(Map<String, dynamic> json) =>
      LogTaskStatusObjData(
        intProjectTaskStatusId: json["intProjectTask_StatusID"],
        intProjectTaskId: json["intProjectTaskID"],
        txtResourceCode: json["txtResourceCode"],
        txtRemark: json["txtRemark"],
        txtStatus: json["txtStatus"],
        txtGuid: json["txtGUID"],
        decProgressValue: json["decProgressValue"],
        bitActive: json["bitActive"],
        txtTaskDescription: json["txtTaskDescription"],
        txtCategory: json["txtCategory"],
        dtmInsertedDate: DateTime.parse(json["dtmInsertedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "intProjectTask_StatusID": intProjectTaskStatusId,
        "intProjectTaskID": intProjectTaskId,
        "txtResourceCode": txtResourceCode,
        "txtRemark": txtRemark,
        "txtStatus": txtStatus,
        "txtGUID": txtGuid,
        "decProgressValue": decProgressValue,
        "bitActive": bitActive,
        "txtTaskDescription": txtTaskDescription,
        "txtCategory": txtCategory,
        "dtmInsertedDate": dtmInsertedDate.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        intProjectTaskStatusId,
        intProjectTaskId,
        txtResourceCode,
        txtRemark,
        txtStatus,
        txtGuid,
        decProgressValue,
        bitActive,
        txtTaskDescription,
        txtCategory,
        dtmInsertedDate,
      ];
}
