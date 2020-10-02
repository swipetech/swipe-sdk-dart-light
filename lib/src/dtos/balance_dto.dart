// To parse this JSON data, do
//
//     final balanceModel = balanceModelFromJson(jsonString);

import 'dart:convert';

BalanceDTO balanceModelFromJson(String str) => BalanceDTO.fromJson(json.decode(str));

String balanceModelToJson(BalanceDTO data) => json.encode(data.toJson());

class BalanceDTO {
  BalanceDTO({
    this.assetId,
    this.amount,
  });

  final String assetId;
  final String amount;

  BalanceDTO copyWith({
    String assetId,
    String amount,
  }) =>
      BalanceDTO(
        assetId: assetId ?? this.assetId,
        amount: amount ?? this.amount,
      );

  factory BalanceDTO.fromJson(Map<String, dynamic> json) => BalanceDTO(
    assetId: json["assetId"] == null ? null : json["assetId"],
    amount: json["amount"] == null ? null : json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "assetId": assetId == null ? null : assetId,
    "amount": amount == null ? null : amount,
  };
}