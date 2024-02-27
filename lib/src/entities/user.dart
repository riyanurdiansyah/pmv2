import 'dart:convert';

import 'package:equatable/equatable.dart';

UserEntity userEntityFromJson(String str) =>
    UserEntity.fromJson(json.decode(str));

String userEntityToJson(UserEntity data) => json.encode(data.toJson());

class UserEntity extends Equatable {
  final bool bitSuccess;
  final ObjData objData;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  const UserEntity({
    required this.bitSuccess,
    required this.objData,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  UserEntity copyWith({
    bool? bitSuccess,
    ObjData? objData,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      UserEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        objData: objData ?? this.objData,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        bitSuccess: json["bitSuccess"],
        objData: ObjData.fromJson(json["objData"]),
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

  factory UserEntity.emptyObject() => UserEntity(
        bitSuccess: false,
        objData: ObjData.emptyObject(),
        txtMessage: "",
        txtStackTrace: "",
        txtGuid: "",
      );

  @override
  List<Object?> get props =>
      [bitSuccess, objData, txtMessage, txtStackTrace, txtGuid];
}

class ObjData extends Equatable {
  final int intUserId;
  final String txtUserName;
  final String txtFullName;
  final String txtNick;
  final String txtEmployeeId;
  final String txtEmail;
  final bool bitActive;
  final String lastlogin;
  final List<LtRole> ltRoles;

  const ObjData({
    required this.intUserId,
    required this.txtUserName,
    required this.txtFullName,
    required this.txtNick,
    required this.txtEmployeeId,
    required this.txtEmail,
    required this.bitActive,
    required this.lastlogin,
    required this.ltRoles,
  });

  ObjData copyWith({
    int? intUserId,
    String? txtUserName,
    String? txtFullName,
    String? txtNick,
    String? txtEmployeeId,
    String? txtEmail,
    bool? bitActive,
    String? lastlogin,
    List<LtRole>? ltRoles,
  }) =>
      ObjData(
        intUserId: intUserId ?? this.intUserId,
        txtUserName: txtUserName ?? this.txtUserName,
        txtFullName: txtFullName ?? this.txtFullName,
        txtNick: txtNick ?? this.txtNick,
        txtEmployeeId: txtEmployeeId ?? this.txtEmployeeId,
        txtEmail: txtEmail ?? this.txtEmail,
        bitActive: bitActive ?? this.bitActive,
        lastlogin: lastlogin ?? this.lastlogin,
        ltRoles: ltRoles ?? this.ltRoles,
      );

  factory ObjData.fromJson(Map<String, dynamic> json) => ObjData(
        intUserId: json["intUserID"] ?? 0,
        txtUserName: json["txtUserName"] ?? "",
        txtFullName: json["txtFullName"] ?? "",
        txtNick: json["txtNick"] ?? "",
        txtEmployeeId: json["txtEmployeeID"] ?? "",
        txtEmail: json["txtEmail"] ?? "",
        bitActive: json["bitActive"] ?? false,
        lastlogin: json["lastlogin"] ?? "",
        ltRoles: json["ltRoles"] == null
            ? []
            : List<LtRole>.from(json["ltRoles"].map((x) => LtRole.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "intUserID": intUserId,
        "txtUserName": txtUserName,
        "txtFullName": txtFullName,
        "txtNick": txtNick,
        "txtEmployeeID": txtEmployeeId,
        "txtEmail": txtEmail,
        "bitActive": bitActive,
        "lastlogin": lastlogin,
        "ltRoles": List<dynamic>.from(ltRoles.map((x) => x.toJson())),
      };

  factory ObjData.emptyObject() => const ObjData(
        intUserId: 0,
        txtUserName: "",
        txtFullName: "",
        txtNick: "",
        txtEmployeeId: "",
        txtEmail: "",
        bitActive: false,
        lastlogin: "",
        ltRoles: [],
      );

  @override
  List<Object?> get props => [
        intUserId,
        txtUserName,
        txtFullName,
        txtNick,
        txtEmployeeId,
        txtEmail,
        bitActive,
        lastlogin,
        ltRoles,
      ];
}

class LtRole extends Equatable {
  final int intRoleId;
  final String txtRoleName;
  final bool bitSuperuser;
  final String txtGuid;
  final dynamic txtCreatedBy;
  final dynamic dtmCreatedDate;
  final String txtUpdatedBy;
  final dynamic dtmUpdatedDate;
  final List<MRoleAccess> mRoleAccesses;
  final List<dynamic> mUserRoles;

  const LtRole({
    required this.intRoleId,
    required this.txtRoleName,
    required this.bitSuperuser,
    required this.txtGuid,
    required this.txtCreatedBy,
    required this.dtmCreatedDate,
    required this.txtUpdatedBy,
    required this.dtmUpdatedDate,
    required this.mRoleAccesses,
    required this.mUserRoles,
  });

  LtRole copyWith({
    int? intRoleId,
    String? txtRoleName,
    bool? bitSuperuser,
    String? txtGuid,
    dynamic txtCreatedBy,
    dynamic dtmCreatedDate,
    String? txtUpdatedBy,
    dynamic dtmUpdatedDate,
    List<MRoleAccess>? mRoleAccesses,
    List<dynamic>? mUserRoles,
  }) =>
      LtRole(
        intRoleId: intRoleId ?? this.intRoleId,
        txtRoleName: txtRoleName ?? this.txtRoleName,
        bitSuperuser: bitSuperuser ?? this.bitSuperuser,
        txtGuid: txtGuid ?? this.txtGuid,
        txtCreatedBy: txtCreatedBy ?? this.txtCreatedBy,
        dtmCreatedDate: dtmCreatedDate ?? this.dtmCreatedDate,
        txtUpdatedBy: txtUpdatedBy ?? this.txtUpdatedBy,
        dtmUpdatedDate: dtmUpdatedDate ?? this.dtmUpdatedDate,
        mRoleAccesses: mRoleAccesses ?? this.mRoleAccesses,
        mUserRoles: mUserRoles ?? this.mUserRoles,
      );

  factory LtRole.fromJson(Map<String, dynamic> json) => LtRole(
        intRoleId: json["IntRoleId"],
        txtRoleName: json["TxtRoleName"],
        bitSuperuser: json["BitSuperuser"],
        txtGuid: json["TxtGuid"],
        txtCreatedBy: json["TxtCreatedBy"],
        dtmCreatedDate: json["DtmCreatedDate"],
        txtUpdatedBy: json["TxtUpdatedBy"],
        dtmUpdatedDate: json["DtmUpdatedDate"],
        mRoleAccesses: List<MRoleAccess>.from(
            json["MRoleAccesses"].map((x) => MRoleAccess.fromJson(x))),
        mUserRoles: List<dynamic>.from(json["MUserRoles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "IntRoleId": intRoleId,
        "TxtRoleName": txtRoleName,
        "BitSuperuser": bitSuperuser,
        "TxtGuid": txtGuid,
        "TxtCreatedBy": txtCreatedBy,
        "DtmCreatedDate": dtmCreatedDate,
        "TxtUpdatedBy": txtUpdatedBy,
        "DtmUpdatedDate": dtmUpdatedDate,
        "MRoleAccesses":
            List<dynamic>.from(mRoleAccesses.map((x) => x.toJson())),
        "MUserRoles": List<dynamic>.from(mUserRoles.map((x) => x)),
      };

  factory LtRole.emptyObject() => const LtRole(
        intRoleId: 0,
        txtRoleName: "",
        bitSuperuser: false,
        txtGuid: "",
        txtCreatedBy: "",
        dtmCreatedDate: "",
        txtUpdatedBy: "",
        dtmUpdatedDate: "",
        mRoleAccesses: [],
        mUserRoles: [],
      );

  @override
  List<Object?> get props => [
        intRoleId,
        txtRoleName,
        bitSuperuser,
        txtGuid,
        txtCreatedBy,
        dtmCreatedDate,
        txtUpdatedBy,
        dtmUpdatedDate,
        mRoleAccesses,
        mUserRoles,
      ];
}

class MRoleAccess extends Equatable {
  final int intRoleAccessId;
  final int intRoleId;
  final int intModuleId;
  final bool bitEdit;
  final bool bitView;
  final bool bitDelete;
  final dynamic bitPrint;
  final String txtGuid;
  final dynamic txtCreatedBy;
  final dynamic dtmCreatedDate;
  final String txtUpdatedBy;
  final dynamic dtmUpdatedDate;
  final dynamic intModule;
  final dynamic intRole;

  const MRoleAccess({
    required this.intRoleAccessId,
    required this.intRoleId,
    required this.intModuleId,
    required this.bitEdit,
    required this.bitView,
    required this.bitDelete,
    required this.bitPrint,
    required this.txtGuid,
    required this.txtCreatedBy,
    required this.dtmCreatedDate,
    required this.txtUpdatedBy,
    required this.dtmUpdatedDate,
    required this.intModule,
    required this.intRole,
  });

  MRoleAccess copyWith({
    int? intRoleAccessId,
    int? intRoleId,
    int? intModuleId,
    bool? bitEdit,
    bool? bitView,
    bool? bitDelete,
    dynamic bitPrint,
    String? txtGuid,
    dynamic txtCreatedBy,
    dynamic dtmCreatedDate,
    String? txtUpdatedBy,
    dynamic dtmUpdatedDate,
    dynamic intModule,
    dynamic intRole,
  }) =>
      MRoleAccess(
        intRoleAccessId: intRoleAccessId ?? this.intRoleAccessId,
        intRoleId: intRoleId ?? this.intRoleId,
        intModuleId: intModuleId ?? this.intModuleId,
        bitEdit: bitEdit ?? this.bitEdit,
        bitView: bitView ?? this.bitView,
        bitDelete: bitDelete ?? this.bitDelete,
        bitPrint: bitPrint ?? this.bitPrint,
        txtGuid: txtGuid ?? this.txtGuid,
        txtCreatedBy: txtCreatedBy ?? this.txtCreatedBy,
        dtmCreatedDate: dtmCreatedDate ?? this.dtmCreatedDate,
        txtUpdatedBy: txtUpdatedBy ?? this.txtUpdatedBy,
        dtmUpdatedDate: dtmUpdatedDate ?? this.dtmUpdatedDate,
        intModule: intModule ?? this.intModule,
        intRole: intRole ?? this.intRole,
      );

  factory MRoleAccess.fromJson(Map<String, dynamic> json) => MRoleAccess(
        intRoleAccessId: json["IntRoleAccessId"],
        intRoleId: json["IntRoleId"],
        intModuleId: json["IntModuleId"],
        bitEdit: json["BitEdit"],
        bitView: json["BitView"],
        bitDelete: json["BitDelete"],
        bitPrint: json["BitPrint"],
        txtGuid: json["TxtGuid"],
        txtCreatedBy: json["TxtCreatedBy"],
        dtmCreatedDate: json["DtmCreatedDate"],
        txtUpdatedBy: json["TxtUpdatedBy"],
        dtmUpdatedDate: json["DtmUpdatedDate"],
        intModule: json["IntModule"],
        intRole: json["IntRole"],
      );

  Map<String, dynamic> toJson() => {
        "IntRoleAccessId": intRoleAccessId,
        "IntRoleId": intRoleId,
        "IntModuleId": intModuleId,
        "BitEdit": bitEdit,
        "BitView": bitView,
        "BitDelete": bitDelete,
        "BitPrint": bitPrint,
        "TxtGuid": txtGuid,
        "TxtCreatedBy": txtCreatedBy,
        "DtmCreatedDate": dtmCreatedDate,
        "TxtUpdatedBy": txtUpdatedBy,
        "DtmUpdatedDate": dtmUpdatedDate,
        "IntModule": intModule,
        "IntRole": intRole,
      };

  @override
  List<Object?> get props => [
        intRoleAccessId,
        intRoleId,
        intModuleId,
        bitEdit,
        bitView,
        bitDelete,
        bitPrint,
        txtGuid,
        txtCreatedBy,
        dtmCreatedDate,
        txtUpdatedBy,
        dtmUpdatedDate,
        intModule,
        intRole
      ];
}
