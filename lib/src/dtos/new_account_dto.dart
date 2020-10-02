// To parse this JSON data, do
//
//     final newAccountDto = newAccountDtoFromJson(jsonString);

import 'dart:convert';

NewAccountDTO newAccountDtoFromJson(String str) => NewAccountDTO.fromJson(json.decode(str));

String newAccountDtoToJson(NewAccountDTO data) => json.encode(data.toJson());

class NewAccountDTO {
  NewAccountDTO({
    this.fields,
  });

  final Map<String, dynamic> fields;

  NewAccountDTO copyWith({
    Map<String, dynamic> fields,
  }) =>
      NewAccountDTO(
        fields: fields ?? this.fields,
      );

  factory NewAccountDTO.fromJson(Map<String, dynamic> json) => NewAccountDTO(
    fields: json["fields"]
  );

  Map<String, dynamic> toJson() => {
    "fields": fields
  };
}
