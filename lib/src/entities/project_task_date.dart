import 'dart:convert';

import 'package:equatable/equatable.dart';

ProjectTaskDateEntity projectTaskDateEntityFromJson(String str) =>
    ProjectTaskDateEntity.fromJson(json.decode(str));

String projectTaskDateEntityToJson(ProjectTaskDateEntity data) =>
    json.encode(data.toJson());

class ProjectTaskDateEntity extends Equatable {
  final bool bitSuccess;
  final List<ProjectTaskDateObjData> objData;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  const ProjectTaskDateEntity({
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  ProjectTaskDateEntity copyWith({
    bool? bitSuccess,
    List<ProjectTaskDateObjData>? objData,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      ProjectTaskDateEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory ProjectTaskDateEntity.fromJson(Map<String, dynamic> json) =>
      ProjectTaskDateEntity(
        bitSuccess: json["bitSuccess"],
        objData: List<ProjectTaskDateObjData>.from(
            json["objData"].map((x) => ProjectTaskDateObjData.fromJson(x))),
        txtMessage: json["txtMessage"],
        txtStackTrace: json["txtStackTrace"],
        txtGuid: json["txtGUID"],
      );

  factory ProjectTaskDateEntity.emptyObject() => const ProjectTaskDateEntity(
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

class ProjectTaskDateObjData {
  final String title;
  final String start;
  final String end;
  final String color;

  ProjectTaskDateObjData({
    required this.title,
    required this.start,
    required this.end,
    required this.color,
  });

  ProjectTaskDateObjData copyWith({
    String? title,
    String? start,
    String? end,
    String? color,
  }) =>
      ProjectTaskDateObjData(
        title: title ?? this.title,
        start: start ?? this.start,
        end: end ?? this.end,
        color: color ?? this.color,
      );

  factory ProjectTaskDateObjData.fromJson(Map<String, dynamic> json) =>
      ProjectTaskDateObjData(
        title: json["title"],
        start: json["start"],
        end: json["end"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "start": start,
        "end": end,
        "color": color,
      };
}
