import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:swipe_sdk/src/exceptions/swipe_client_exception.dart';
import 'package:swipe_sdk/src/services/http_data.dart';
import 'package:swipe_sdk/swipe_sdk.dart';
import 'package:swipe_sdk/src/constants/http_headers.dart';

class HttpPipeline {
  final BaseClient _client = Client();

  final String _key;
  final String _secret;
  String _httpHeadersAccessKey;

  Request _request;

  SearchOptions _searchOptions;
  String _url, _method;
  Map _body;

  HttpData _httpData;

  Response response;

  HttpPipeline._(this._key, this._secret);

  factory HttpPipeline.withUser(HttpData httpData) {
    final key = httpData.session.sessionId;
    final secret = httpData.options.apiKey;
    final http = _buildHttpRequest(key, secret, httpData);
    http._httpHeadersAccessKey = HttpHeaders.LOGIN_SESSION_ID;
    return http;
  }

  factory HttpPipeline.withoutUser(HttpData httpData) {
    final key = httpData.options.apiKey;
    final secret = httpData.options.secret;
    final http = _buildHttpRequest(key, secret, httpData);
    http._httpHeadersAccessKey = HttpHeaders.API_KEY;
    return http;
  }

  static HttpPipeline _buildHttpRequest(key, secret, httpData) {
    final http = HttpPipeline._(key, secret);
    http._httpData = httpData;
    return http;
  }

  HttpPipeline url(String url) {
    this._url = url;
    return this;
  }

  HttpPipeline method(String method) {
    this._method = method;
    return this;
  }

  HttpPipeline searchOptions(SearchOptions so) {
    this._searchOptions = so;
    return this;
  }

  HttpPipeline addBody(Map<String, dynamic> body) {
    this._body = body;
    return this;
  }

  HttpPipeline build() {
    final Uri url = this._buildUrl();
    Request request = Request(_method, url);
    request = _buildHeaders(request);
    request = _buildBody(request);
    this._request = request;
    return this;
  }

  Uri _buildUrl() {
    final queryParams = this._searchOptions?.queryParams;
    return Uri.https(this._httpData.options.baseUrl, _url, queryParams);
  }

  Request _buildHeaders(Request request) {
    final timestamp = _getTimestamp();
    request.headers['content-type'] = 'application/json';
    request.headers['Access-Control-Allow-Origin'] = '*';
    request.headers[HttpHeaders.TIMESTAMP] = timestamp;
    request.headers[HttpHeaders.SIGNATURE] = _signRequest(timestamp);
    request.headers[this._httpHeadersAccessKey] = _key;
    return request;
  }

  String _signRequest(String timestamp) {
    final aux = _key + _method + timestamp + _url.toString();
    var hmacSha256 = new Hmac(sha256, utf8.encode(this._secret)); // HMAC-SHA256
    var digest = hmacSha256.convert(utf8.encode(aux));
    return base64Encode(digest.bytes);
  }

  Request _buildBody(Request request) {
    if(_body != null) {
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode(_body);
    }
    return request;
  }

  Future<HttpPipeline> makeAsyncRequest() async {
    final streamedResponse = await _client.send(_request);
    final Response response = await Response.fromStream(streamedResponse);
    final body = this._extractBody(response);
    _validateBodyNResponse(body, response);
    this._body = body;
    return this;
  }

  _validateBodyNResponse(body, Response response) {
    if (_isCodeStatusWrong(response) && !(body is Map)) if (body == null)
      throw Exception("Error: ${response.statusCode}, and body is null");
    else
      _bodyHasError(body);
  }

  _extractBody(Response response) {
    try {
      return response.body.isNotEmpty ? jsonDecode(response.body) : {};
    } on FormatException {
      final contentType = response.headers['content-type'];
      if (contentType != null && !contentType.contains('application/json')) {
        print(response.body);
        throw Exception(
            'Returned value was not JSON. Did the uri end with ".json"?');
      }
      rethrow;
    }
  }

  _isCodeStatusWrong(Response response) =>
      response.statusCode < 200 || response.statusCode >= 300;

  _bodyHasError(body) => throw SwipeClientException.fromJson(body);

  String _getTimestamp() =>
      (DateTime.now().millisecondsSinceEpoch / 1000).toString();

  format(t) {
    if (_body.isEmpty)
      return t.fromJson(Map<String, dynamic>());
    else if (_body["data"] is Map)
      return _formatWhenMap(_body, t);
    else
      return _formatWhenList(_body, t);
  }

  _formatWhenMap(bodyJson, t) =>
      bodyJson["data"].isNotEmpty ? t.fromJson(bodyJson['data'] ?? {}) : null;

  _formatWhenList(bodyJson, t) =>
      bodyJson["data"].map((e) => t.fromJson(e)).toList();
}
