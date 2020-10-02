// To parse this JSON data, do
//
//     final swpError = swpErrorFromJson(jsonString);

import 'dart:convert';

import 'package:swipe_sdk/src/dtos/sub_error_dto.dart';

SwpError swpErrorFromJson(String str) => SwpError.fromJson(json.decode(str));

String swpErrorToJson(SwpError data) => json.encode(data.toJson());

class SwpError {
  SwpError({
    this.code,
    this.message,
    this.subError,
  });

  final String code;
  final String message;
  final List<SubErrorDTO> subError;

  SwpError copyWith({
    String code,
    String message,
    List<dynamic> subError,
  }) =>
      SwpError(
        code: code ?? this.code,
        message: message ?? this.message,
        subError: subError ?? this.subError,
      );

  factory SwpError.fromJson(Map<String, dynamic> json) => SwpError(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    subError: json["subError"] == null ? null : List<dynamic>.from(json["subError"].map((x) => SubErrorDTO.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "subError": subError == null ? null : List<Map<String, dynamic>>.from(subError.map((x) => x.toJson())),
  };
}
