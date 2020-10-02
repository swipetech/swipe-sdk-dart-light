// To parse this JSON data, do
//
//     final searchOptions = searchOptionsFromJson(jsonString);

import 'dart:convert';

import 'package:swipe_sdk/src/models/pagination_params.dart';

SearchOptions searchOptionsFromJson(String str) => SearchOptions.fromJson(json.decode(str));

String searchOptionsToJson(SearchOptions data) => json.encode(data.toJson());

class SearchOptions {
  SearchOptions({
    this.queryParams,
    this.fields,
    this.pagination,
  });

  final Map<String, String> queryParams;
  final Map<String, dynamic> fields;
  final PaginationParams pagination;

  SearchOptions copyWith({
    int queryParams,
    int fields,
    PaginationParams pagination,
  }) =>
      SearchOptions(
        queryParams: queryParams ?? this.queryParams,
        fields: fields ?? this.fields,
        pagination: pagination ?? this.pagination,
      );

  factory SearchOptions.fromJson(Map<String, dynamic> json) => SearchOptions(
    queryParams: json["queryParams"] == null ? null : json["queryParams"],
    fields: json["fields"] == null ? null : json["fields"],
    pagination: json["pagination"] == null ? null : PaginationParams.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "queryParams": queryParams == null ? null : queryParams,
    "fields": fields == null ? null : fields,
    "pagination": pagination == null ? null : pagination.toJson(),
  };
}

