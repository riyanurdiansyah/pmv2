import 'dart:convert';

import 'package:equatable/equatable.dart';

TaskStatusEntity taskStatusEntityFromJson(String str) =>
    TaskStatusEntity.fromJson(json.decode(str));

String taskStatusEntityToJson(TaskStatusEntity data) =>
    json.encode(data.toJson());

class TaskStatusEntity extends Equatable {
  final bool bitSuccess;
  final List<TaskStatusObjData> objData;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  const TaskStatusEntity({
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  TaskStatusEntity copyWith({
    bool? bitSuccess,
    List<TaskStatusObjData>? objData,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      TaskStatusEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory TaskStatusEntity.fromJson(Map<String, dynamic> json) =>
      TaskStatusEntity(
        bitSuccess: json["bitSuccess"],
        objData: List<TaskStatusObjData>.from(
            json["objData"].map((x) => TaskStatusObjData.fromJson(x))),
        txtMessage: json["txtMessage"],
        txtStackTrace: json["txtStackTrace"],
        txtGuid: json["txtGUID"],
      );

  factory TaskStatusEntity.emptyObject() => const TaskStatusEntity(
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

class TaskStatusObjData extends Equatable {
  final int id;
  final String name;
  final double progress;
  final bool finalFlag;

  const TaskStatusObjData({
    required this.id,
    required this.name,
    required this.progress,
    required this.finalFlag,
  });

  TaskStatusObjData copyWith({
    int? id,
    String? name,
    double? progress,
    bool? finalFlag,
  }) =>
      TaskStatusObjData(
        id: id ?? this.id,
        name: name ?? this.name,
        progress: progress ?? this.progress,
        finalFlag: finalFlag ?? this.finalFlag,
      );

  factory TaskStatusObjData.fromJson(Map<String, dynamic> json) =>
      TaskStatusObjData(
        id: json["ID"],
        name: json["Name"],
        progress: json["Progress"],
        finalFlag: json["FinalFlag"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "Progress": progress,
        "FinalFlag": finalFlag,
      };

  @override
  List<Object?> get props => [id, name, progress, finalFlag];
}
