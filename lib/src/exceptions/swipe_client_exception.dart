// To parse this JSON data, do
//
//     final swipeClientException = swipeClientExceptionFromJson(jsonString);

import 'dart:convert';

SwipeClientException swipeClientExceptionFromJson(String str) =>
    SwipeClientException.fromJson(json.decode(str));

String swipeClientExceptionToJson(SwipeClientException data) =>
    json.encode(data.toJson());

class SwipeClientException {
  SwipeClientException({
    this.name,
    this.message,
    this.code,
    this.subErrors,
  });

  final String name;
  final String message;
  final String code;
  final List<dynamic> subErrors;

  SwipeClientException copyWith({
    String name,
    String message,
    String code,
    List<dynamic> subErrors,
  }) =>
      SwipeClientException(
        name: name ?? this.name,
        message: message ?? this.message,
        code: code ?? this.code,
        subErrors: subErrors ?? this.subErrors,
      );

  factory SwipeClientException.fromJson(Map<String, dynamic> json) {
    return SwipeClientException(
      name: json["name"] == null ? null : json["name"],
      message: json["message"] == null ? null : json["message"],
      code: json["code"] == null ? null : json["code"],
      subErrors: json["subErrors"] == null
          ? null
          : List<dynamic>.from(json["subErrors"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "message": message == null ? null : message,
        "code": code == null ? null : code,
        "subErrors": subErrors == null
            ? null
            : List<dynamic>.from(subErrors.map((x) => x)),
      };
  @override
  String toString() {
    return "name: $name\ncode: $code\nmessage: $message\n subErrors: $subErrors";
  }
}
