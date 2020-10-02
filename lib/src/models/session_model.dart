// To parse this JSON data, do
//
//     final sessionModel = sessionModelFromJson(jsonString);

import 'dart:convert';

SessionModel sessionModelFromJson(String str) => SessionModel.fromJson(json.decode(str));

String sessionModelToJson(SessionModel data) => json.encode(data.toJson());

class SessionModel {
  SessionModel({
    this.sessionId,
    this.accountId,
  });

  final String sessionId;
  final String accountId;

  SessionModel copyWith({
    String sessionId,
    String accountId,
  }) =>
      SessionModel(
        sessionId: sessionId ?? this.sessionId,
        accountId: accountId ?? this.accountId,
      );

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
    sessionId: json["sessionId"] == null ? null : json["sessionId"],
    accountId: json["accountId"] == null ? null : json["accountId"],
  );

  Map<String, dynamic> toJson() => {
    "sessionId": sessionId == null ? null : sessionId,
    "accountId": accountId == null ? null : accountId,
  };
}
