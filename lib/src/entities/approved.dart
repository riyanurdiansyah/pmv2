import 'dart:convert';

import 'package:pman/src/entities/approval.dart';

ApprovedEntity approvedEntityFromJson(String str) =>
    ApprovedEntity.fromJson(json.decode(str));

String approvedEntityToJson(ApprovedEntity data) => json.encode(data.toJson());

class ApprovedEntity {
  final String txtToken;
  final ProgramDat programDat;
  final String txtUsername;
  final String txtLangId;
  final String txtProgramCode;
  final String txtFunction;
  final ApprovalObjData objRequestData;
  final bool bitSuccess;
  final dynamic objData;
  final String txtMessage;
  final bool bitError;
  final String txtErrorMessage;
  final String txtGuid;
  final String txtStackTrace;

  ApprovedEntity({
    required this.txtToken,
    required this.programDat,
    required this.txtUsername,
    required this.txtLangId,
    required this.txtProgramCode,
    required this.txtFunction,
    required this.objRequestData,
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.bitError,
    required this.txtErrorMessage,
    required this.txtGuid,
    required this.txtStackTrace,
  });

  ApprovedEntity copyWith({
    String? txtToken,
    ProgramDat? programDat,
    String? txtUsername,
    String? txtLangId,
    String? txtProgramCode,
    String? txtFunction,
    ApprovalObjData? objRequestData,
    bool? bitSuccess,
    dynamic objData,
    String? txtMessage,
    bool? bitError,
    String? txtErrorMessage,
    String? txtGuid,
    String? txtStackTrace,
  }) =>
      ApprovedEntity(
        txtToken: txtToken ?? this.txtToken,
        programDat: programDat ?? this.programDat,
        txtUsername: txtUsername ?? this.txtUsername,
        txtLangId: txtLangId ?? this.txtLangId,
        txtProgramCode: txtProgramCode ?? this.txtProgramCode,
        txtFunction: txtFunction ?? this.txtFunction,
        objRequestData: objRequestData ?? this.objRequestData,
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        bitError: bitError ?? this.bitError,
        txtErrorMessage: txtErrorMessage ?? this.txtErrorMessage,
        txtGuid: txtGuid ?? this.txtGuid,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
      );

  factory ApprovedEntity.fromJson(Map<String, dynamic> json) => ApprovedEntity(
        txtToken: json["txtToken"],
        programDat: ProgramDat.fromJson(json["ProgramDat"]),
        txtUsername: json["txtUsername"],
        txtLangId: json["txtLangID"],
        txtProgramCode: json["txtProgramCode"],
        txtFunction: json["txtFunction"],
        objRequestData: ApprovalObjData.fromJson(json["objRequestData"]),
        bitSuccess: json["bitSuccess"],
        objData: json["objData"],
        txtMessage: json["txtMessage"],
        bitError: json["bitError"],
        txtErrorMessage: json["txtErrorMessage"],
        txtGuid: json["txtGUID"],
        txtStackTrace: json["txtStackTrace"],
      );

  Map<String, dynamic> toJson() => {
        "txtToken": txtToken,
        "ProgramDat": programDat.toJson(),
        "txtUsername": txtUsername,
        "txtLangID": txtLangId,
        "txtProgramCode": txtProgramCode,
        "txtFunction": txtFunction,
        "objRequestData": objRequestData.toJson(),
        "bitSuccess": bitSuccess,
        "objData": {},
        "txtMessage": txtMessage,
        "bitError": bitError,
        "txtErrorMessage": txtErrorMessage,
        "txtGUID": txtGuid,
        "txtStackTrace": txtStackTrace,
      };
}

class ProgramDat {
  final int intProgramId;
  final String txtProgramCode;
  final String txtProgramName;
  final String txtSolutionName;
  final String txtSourceRepository;
  final String txtDescription;
  final bool bitActive;
  final int intDevelopmentYear;
  final int intGoLiveYear;
  final String txtInsertedBy;
  final String dtInserted;
  final String txtUpdatedBy;
  final String dtUpdated;
  final String txtSecurityUsername;
  final String txtSecurityPassword;
  final String txtSecurityType;
  final String txtSecurityUrlToken;
  final String txtSecurityClientId;
  final String txtGuid;

  ProgramDat({
    required this.intProgramId,
    required this.txtProgramCode,
    required this.txtProgramName,
    required this.txtSolutionName,
    required this.txtSourceRepository,
    required this.txtDescription,
    required this.bitActive,
    required this.intDevelopmentYear,
    required this.intGoLiveYear,
    required this.txtInsertedBy,
    required this.dtInserted,
    required this.txtUpdatedBy,
    required this.dtUpdated,
    required this.txtSecurityUsername,
    required this.txtSecurityPassword,
    required this.txtSecurityType,
    required this.txtSecurityUrlToken,
    required this.txtSecurityClientId,
    required this.txtGuid,
  });

  ProgramDat copyWith({
    int? intProgramId,
    String? txtProgramCode,
    String? txtProgramName,
    String? txtSolutionName,
    String? txtSourceRepository,
    String? txtDescription,
    bool? bitActive,
    int? intDevelopmentYear,
    int? intGoLiveYear,
    String? txtInsertedBy,
    String? dtInserted,
    String? txtUpdatedBy,
    String? dtUpdated,
    String? txtSecurityUsername,
    String? txtSecurityPassword,
    String? txtSecurityType,
    String? txtSecurityUrlToken,
    String? txtSecurityClientId,
    String? txtGuid,
  }) =>
      ProgramDat(
        intProgramId: intProgramId ?? this.intProgramId,
        txtProgramCode: txtProgramCode ?? this.txtProgramCode,
        txtProgramName: txtProgramName ?? this.txtProgramName,
        txtSolutionName: txtSolutionName ?? this.txtSolutionName,
        txtSourceRepository: txtSourceRepository ?? this.txtSourceRepository,
        txtDescription: txtDescription ?? this.txtDescription,
        bitActive: bitActive ?? this.bitActive,
        intDevelopmentYear: intDevelopmentYear ?? this.intDevelopmentYear,
        intGoLiveYear: intGoLiveYear ?? this.intGoLiveYear,
        txtInsertedBy: txtInsertedBy ?? this.txtInsertedBy,
        dtInserted: dtInserted ?? this.dtInserted,
        txtUpdatedBy: txtUpdatedBy ?? this.txtUpdatedBy,
        dtUpdated: dtUpdated ?? this.dtUpdated,
        txtSecurityUsername: txtSecurityUsername ?? this.txtSecurityUsername,
        txtSecurityPassword: txtSecurityPassword ?? this.txtSecurityPassword,
        txtSecurityType: txtSecurityType ?? this.txtSecurityType,
        txtSecurityUrlToken: txtSecurityUrlToken ?? this.txtSecurityUrlToken,
        txtSecurityClientId: txtSecurityClientId ?? this.txtSecurityClientId,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory ProgramDat.fromJson(Map<String, dynamic> json) => ProgramDat(
        intProgramId: json["intProgramID"],
        txtProgramCode: json["txtProgramCode"],
        txtProgramName: json["txtProgramName"],
        txtSolutionName: json["txtSolutionName"],
        txtSourceRepository: json["txtSourceRepository"],
        txtDescription: json["txtDescription"],
        bitActive: json["bitActive"],
        intDevelopmentYear: json["intDevelopmentYear"],
        intGoLiveYear: json["intGoLiveYear"],
        txtInsertedBy: json["txtInsertedBy"],
        dtInserted: json["dtInserted"],
        txtUpdatedBy: json["txtUpdatedBy"],
        dtUpdated: json["dtUpdated"],
        txtSecurityUsername: json["txtSecurity_Username"],
        txtSecurityPassword: json["txtSecurity_Password"],
        txtSecurityType: json["txtSecurity_Type"],
        txtSecurityUrlToken: json["txtSecurity_UrlToken"],
        txtSecurityClientId: json["txtSecurity_ClientID"],
        txtGuid: json["txtGUID"],
      );

  Map<String, dynamic> toJson() => {
        "intProgramID": intProgramId,
        "txtProgramCode": txtProgramCode,
        "txtProgramName": txtProgramName,
        "txtSolutionName": txtSolutionName,
        "txtSourceRepository": txtSourceRepository,
        "txtDescription": txtDescription,
        "bitActive": bitActive,
        "intDevelopmentYear": intDevelopmentYear,
        "intGoLiveYear": intGoLiveYear,
        "txtInsertedBy": txtInsertedBy,
        "dtInserted": dtInserted,
        "txtUpdatedBy": txtUpdatedBy,
        "dtUpdated": dtUpdated,
        "txtSecurity_Username": txtSecurityUsername,
        "txtSecurity_Password": txtSecurityPassword,
        "txtSecurity_Type": txtSecurityType,
        "txtSecurity_UrlToken": txtSecurityUrlToken,
        "txtSecurity_ClientID": txtSecurityClientId,
        "txtGUID": txtGuid,
      };
}
