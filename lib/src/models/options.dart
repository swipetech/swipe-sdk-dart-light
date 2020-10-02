import 'dart:convert';

Options optionsFromJson(String str) => Options.fromJson(json.decode(str));

String optionsToJson(Options data) => json.encode(data.toJson());

class Options {
  Options({
    this.apiKey,
    this.secret,
    this.baseUrl,
    this.assetId,
  });

  final String apiKey;
  final String secret;
  final String baseUrl;
  final String assetId;

  Options copyWith({
    String apiKey,
    String secret,
    String baseUrl,
    String assetId,
  }) =>
      Options(
        apiKey: apiKey ?? this.apiKey,
        secret: secret ?? this.secret,
        baseUrl: baseUrl ?? this.baseUrl,
        assetId: assetId ?? this.assetId,
      );

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        apiKey: json["apiKey"] == null ? null : json["apiKey"],
        secret: json["secret"] == null ? null : json["secret"],
        baseUrl: json["baseUrl"] == null ? null : json["baseUrl"],
        assetId: json["assetId"] == null ? null : json["assetId"],
      );

  Map<String, dynamic> toJson() => {
        "apiKey": apiKey == null ? null : apiKey,
        "secret": secret == null ? null : secret,
        "baseUrl": baseUrl == null ? null : baseUrl,
        "assetId": assetId == null ? null : assetId,
      };
}
