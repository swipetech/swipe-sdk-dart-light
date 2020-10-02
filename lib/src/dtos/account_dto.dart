// To parse this JSON data, do
//
//     final accountDto = accountDtoFromJson(jsonString);

import 'dart:convert';

import 'package:swipe_sdk/src/dtos/balance_dto.dart';
import 'package:swipe_sdk/src/interfaces/base_dto.dart';

AccountDTO accountDtoFromJson(String str) => AccountDTO.fromJson(json.decode(str));

String accountDtoToJson(AccountDTO data) => json.encode(data.toJson());

class AccountDTO implements BaseDTO<AccountDTO> {
  AccountDTO({
    this.id,
    this.createdAt,
    this.balances,
    this.fields,
  });

  final String id;
  final String createdAt;
  final List<BalanceDTO> balances;
  final Map<String, dynamic> fields;

  AccountDTO copyWith({
    String id,
    String createAt,
    List<BalanceDTO> balances,
    Map<String, dynamic> fields,
  }) =>
      AccountDTO(
        id: id ?? this.id,
        createdAt: createAt ?? this.createdAt,
        balances: balances ?? this.balances,
        fields: fields ?? this.fields,
      );

  factory AccountDTO.fromJson(Map<String, dynamic> json) => AccountDTO(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        balances: json["balances"] == null
            ? null
            : List<BalanceDTO>.from(json["balances"].map<BalanceDTO>((x) => BalanceDTO.fromJson(x))),
        fields: json["fields"]as Map<String, dynamic>,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt,
        "balances": balances == null ? null : List<Map<String, dynamic>>.from(balances.map((x) => x.toJson())),
        "fields": fields,
      };

  @override
  AccountDTO fromJson(Map<String, dynamic> json) {
    return json != null && json.isNotEmpty
        ? AccountDTO.fromJson(json)
        : null;
  }
}
