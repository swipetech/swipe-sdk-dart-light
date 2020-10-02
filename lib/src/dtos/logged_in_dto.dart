// To parse this JSON data, do
//
//     final loggedInDto = loggedInDtoFromJson(jsonString);

import 'dart:convert';

import 'package:swipe_sdk/src/interfaces/base_dto.dart';

LoggedInDto loggedInDtoFromJson(String str) =>
    LoggedInDto.fromJson(json.decode(str));

String loggedInDtoToJson(LoggedInDto data) => json.encode(data.toJson());

class LoggedInDto implements BaseDTO<LoggedInDto> {
  LoggedInDto({
    this.isLogged,
    this.sessionId,
    this.login,
    this.accountId,
  });

  final bool isLogged;
  final String sessionId;
  final String login;
  final String accountId;

  LoggedInDto copyWith({
    bool isLogged,
    String sessionId,
    String login,
    String accountId,
  }) =>
      LoggedInDto(
        isLogged: isLogged ?? this.isLogged,
        sessionId: sessionId ?? this.sessionId,
        login: login ?? this.login,
        accountId: accountId ?? this.accountId,
      );

  factory LoggedInDto.fromJson(Map<String, dynamic> json) => LoggedInDto(
        isLogged: json["isLogged"] == null ? null : json["isLogged"],
        sessionId: json["sessionId"] == null ? null : json["sessionId"],
        login: json["login"] == null ? null : json["login"],
        accountId: json["accountId"] == null ? null : json["accountId"],
      );

  Map<String, dynamic> toJson() => {
        "isLogged": isLogged == null ? null : isLogged,
        "sessionId": sessionId == null ? null : sessionId,
        "login": login == null ? null : login,
        "accountId": accountId == null ? null : accountId,
      };

  @override
  LoggedInDto fromJson(Map<String, dynamic> json) => json != null && json.isNotEmpty ? LoggedInDto(
        isLogged: json["isLogged"] == null ? null : json["isLogged"],
        sessionId: json["sessionId"] == null ? null : json["sessionId"],
        login: json["login"] == null ? null : json["login"],
        accountId: json["accountId"] == null ? null : json["accountId"],
      ) : null;
}
