// To parse this JSON data, do
//
//     final subErrorDto = subErrorDtoFromJson(jsonString);

import 'dart:convert';

SubErrorDTO subErrorDtoFromJson(String str) => SubErrorDTO.fromJson(json.decode(str));

String subErrorDtoToJson(SubErrorDTO data) => json.encode(data.toJson());

class SubErrorDTO {
  SubErrorDTO({
    this.code,
    this.msg,
    this.field,
    this.index,
  });

  final String code;
  final String msg;
  final String field;
  final int index;

  SubErrorDTO copyWith({
    String code,
    String msg,
    String field,
    int index,
  }) =>
      SubErrorDTO(
        code: code ?? this.code,
        msg: msg ?? this.msg,
        field: field ?? this.field,
        index: index ?? this.index,
      );

  factory SubErrorDTO.fromJson(Map<String, dynamic> json) => SubErrorDTO(
    code: json["code"] == null ? null : json["code"],
    msg: json["msg"] == null ? null : json["msg"],
    field: json["field"] == null ? null : json["field"],
    index: json["index"] == null ? null : json["index"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "msg": msg == null ? null : msg,
    "field": field == null ? null : field,
    "index": index == null ? null : index,
  };
}
