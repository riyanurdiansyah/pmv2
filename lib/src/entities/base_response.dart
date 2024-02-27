import 'dart:convert';

BaseResponseEntity baseResponseEntityFromJson(String str) =>
    BaseResponseEntity.fromJson(json.decode(str));

String baseResponseEntityToJson(BaseResponseEntity data) =>
    json.encode(data.toJson());

class BaseResponseEntity {
  final bool bitSuccess;
  final String txtMessage;
  final String txtStackTrace;
  final String txtGuid;

  BaseResponseEntity({
    required this.bitSuccess,
    required this.txtMessage,
    required this.txtStackTrace,
    required this.txtGuid,
  });

  BaseResponseEntity copyWith({
    bool? bitSuccess,
    String? txtMessage,
    String? txtStackTrace,
    String? txtGuid,
  }) =>
      BaseResponseEntity(
        bitSuccess: bitSuccess ?? this.bitSuccess,
        txtMessage: txtMessage ?? this.txtMessage,
        txtStackTrace: txtStackTrace ?? this.txtStackTrace,
        txtGuid: txtGuid ?? this.txtGuid,
      );

  factory BaseResponseEntity.fromJson(Map<String, dynamic> json) =>
      BaseResponseEntity(
        bitSuccess: json["bitSuccess"],
        txtMessage: json["txtMessage"],
        txtStackTrace: json["txtStackTrace"],
        txtGuid: json["txtGUID"],
      );

  Map<String, dynamic> toJson() => {
        "bitSuccess": bitSuccess,
        "txtMessage": txtMessage,
        "txtStackTrace": txtStackTrace,
        "txtGUID": txtGuid,
      };
}
