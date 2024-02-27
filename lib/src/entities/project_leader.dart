import 'dart:convert';

import 'package:equatable/equatable.dart';

ProjectLeaderEntity projectLeaderEntityFromJson(String str) =>
    ProjectLeaderEntity.fromJson(json.decode(str));

String projectLeaderEntityToJson(ProjectLeaderEntity data) =>
    json.encode(data.toJson());

List<ProjectLeaderObjData> projectLeaderObjDatas(String str) =>
    List<ProjectLeaderObjData>.from(
        json.decode(str).map((x) => ProjectLeaderObjData.fromJson(x)));

class ProjectLeaderEntity extends Equatable {
  final bool bitSuccess;
  final List<ProjectLeaderObjData> objData;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  const ProjectLeaderEntity({
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  ProjectLeaderEntity copyWith({
    bool? bitSuccess,
    List<ProjectLeaderObjData>? objData,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      ProjectLeaderEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory ProjectLeaderEntity.fromJson(Map<String, dynamic> json) =>
      ProjectLeaderEntity(
        bitSuccess: json["bitSuccess"],
        objData: List<ProjectLeaderObjData>.from(
            json["objData"].map((x) => ProjectLeaderObjData.fromJson(x))),
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

  @override
  List<Object?> get props =>
      [bitSuccess, objData, txtMessage, txtStackTrace, txtGuid];
}

class ProjectLeaderObjData extends Equatable {
  final String txtPicStreamName;
  final String txtPicStreamNik;

  const ProjectLeaderObjData({
    required this.txtPicStreamName,
    required this.txtPicStreamNik,
  });

  ProjectLeaderObjData copyWith({
    String? txtPicStreamName,
    String? txtPicStreamNik,
  }) =>
      ProjectLeaderObjData(
        txtPicStreamName: txtPicStreamName ?? this.txtPicStreamName,
        txtPicStreamNik: txtPicStreamNik ?? this.txtPicStreamNik,
      );

  factory ProjectLeaderObjData.fromJson(Map<String, dynamic> json) =>
      ProjectLeaderObjData(
        txtPicStreamName: json["txtPICStreamName"],
        txtPicStreamNik: json["txtPICStreamNIK"],
      );

  Map<String, dynamic> toJson() => {
        "txtPICStreamName": txtPicStreamName,
        "txtPICStreamNIK": txtPicStreamNik,
      };

  @override
  List<Object?> get props => [txtPicStreamName, txtPicStreamNik];
}
