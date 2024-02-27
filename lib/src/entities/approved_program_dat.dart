import 'dart:convert';

ApprovedProgramDatEntity approvedProgramDatEntityFromJson(String str) =>
    ApprovedProgramDatEntity.fromJson(json.decode(str));

String approvedProgramDatEntityToJson(ApprovedProgramDatEntity data) =>
    json.encode(data.toJson());

class ApprovedProgramDatEntity {
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
  final DateTime dtInserted;
  final String txtUpdatedBy;
  final DateTime dtUpdated;
  final String txtSecurityUsername;
  final String txtSecurityPassword;
  final String txtSecurityType;
  final String txtSecurityUrlToken;
  final String txtSecurityClientId;
  final String txtGuid;

  ApprovedProgramDatEntity({
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

  ApprovedProgramDatEntity copyWith({
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
    DateTime? dtInserted,
    String? txtUpdatedBy,
    DateTime? dtUpdated,
    String? txtSecurityUsername,
    String? txtSecurityPassword,
    String? txtSecurityType,
    String? txtSecurityUrlToken,
    String? txtSecurityClientId,
    String? txtGuid,
  }) =>
      ApprovedProgramDatEntity(
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

  factory ApprovedProgramDatEntity.fromJson(Map<String, dynamic> json) =>
      ApprovedProgramDatEntity(
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
        dtInserted: DateTime.parse(json["dtInserted"]),
        txtUpdatedBy: json["txtUpdatedBy"],
        dtUpdated: DateTime.parse(json["dtUpdated"]),
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
        "dtInserted": dtInserted.toIso8601String(),
        "txtUpdatedBy": txtUpdatedBy,
        "dtUpdated": dtUpdated.toIso8601String(),
        "txtSecurity_Username": txtSecurityUsername,
        "txtSecurity_Password": txtSecurityPassword,
        "txtSecurity_Type": txtSecurityType,
        "txtSecurity_UrlToken": txtSecurityUrlToken,
        "txtSecurity_ClientID": txtSecurityClientId,
        "txtGUID": txtGuid,
      };
}
