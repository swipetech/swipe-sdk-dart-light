class Secret {
  final String apiKey;
  final String secret;
  final String baseUrl;
  final String backedAsset;

  Secret({
    this.secret = "",
    this.baseUrl = "",
    this.apiKey = "",
    this.backedAsset = "",
  });

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(
      apiKey: jsonMap["api_key"],
      secret: jsonMap["secret"],
      baseUrl: jsonMap["base_url"],
      backedAsset: jsonMap["backed_asset"],
    );
  }
}
