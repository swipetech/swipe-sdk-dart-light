// To parse this JSON data, do
//
//     final paginatioParams = paginatioParamsFromJson(jsonString);

import 'dart:convert';

PaginationParams paginationParamsFromJson(String str) => PaginationParams.fromJson(json.decode(str));

String paginationParamsToJson(PaginationParams data) => json.encode(data.toJson());

class PaginationParams {
  PaginationParams({
    this.limit,
    this.startingAfter,
  });

  final int limit;
  final int startingAfter;

  PaginationParams copyWith({
    int limit,
    int startingAfter,
  }) =>
      PaginationParams(
        limit: limit ?? this.limit,
        startingAfter: startingAfter ?? this.startingAfter,
      );

  factory PaginationParams.fromJson(Map<String, dynamic> json) => PaginationParams(
    limit: json["limit"] == null ? null : json["limit"],
    startingAfter: json["starting_after"] == null ? null : json["starting_after"],
  );

  Map<String, dynamic> toJson() => {
    "limit": limit == null ? null : limit,
    "starting_after": startingAfter == null ? null : startingAfter,
  };
}
