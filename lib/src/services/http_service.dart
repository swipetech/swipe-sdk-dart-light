import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:swipe_sdk/src/services/http_data.dart';
import 'package:swipe_sdk/src/services/http_pipeline_builder.dart';
import 'package:swipe_sdk/swipe_sdk.dart';

class HttpService {
  final HttpData httpData;
  final String service;

  HttpService({
    @required this.httpData,
    @required this.service,
    BaseClient client,
  })  : assert(httpData != null),
        assert(service != null);

  Future<T> getWithUser<T>(String uri, returnType,
      {body, SearchOptions options}) async {
    var httpPipeline =
        _buildInitPipeline(HttpPipeline.withUser(httpData), 'GET', options);
    return (await _baseRequest(uri, httpPipeline, body: body))
        .format(returnType) as T;
  }

  Future<T> postWithUser<T>(String uri, returnType,
      {body, SearchOptions options}) async {
    var httpPipeline =
        _buildInitPipeline(HttpPipeline.withUser(httpData), 'POST', options);
    return (await _baseRequest(uri, httpPipeline, body: body))
        .format(returnType) as T;
  }

  Future<T> deleteWithUser<T>(String uri, returnType,
      {body, SearchOptions options}) async {
    var httpPipeline = _buildInitPipeline(
        HttpPipeline.withUser(httpData), 'DELETE', options);
    return (await _baseRequest(uri, httpPipeline, body: body))
        .format(returnType) as T;
  }

  Future<T> getWithoutUser<T>(String uri, returnType,
      {body, SearchOptions options}) async {
    var httpPipeline =
        _buildInitPipeline(HttpPipeline.withoutUser(httpData), 'GET', options);
    return (await _baseRequest(uri, httpPipeline, body: body))
        .format(returnType) as T;
  }

  Future<T> postWithoutUser<T>(String uri, returnType,
      {body, SearchOptions options}) async {
    var httpPipeline =
        _buildInitPipeline(HttpPipeline.withoutUser(httpData), 'POST', options);
    final result = await _baseRequest(uri, httpPipeline, body: body);
    return result
        .format(returnType) as T;
  }

  Future<T> deleteWithoutUser<T>(String uri, returnType,
      {body, SearchOptions options}) async {
    var httpPipeline = _buildInitPipeline(
        HttpPipeline.withoutUser(httpData), 'DELETE', options);
    return (await _baseRequest(uri, httpPipeline, body: body))
        .format(returnType) as T;
  }

  HttpPipeline _buildInitPipeline(
          HttpPipeline hp, String method, SearchOptions op) =>
      hp.method(method).searchOptions(op);

  //  Future<T> get<T>(String uri, t,
  //          {SearchOptions options, bool useSession = true}) =>
  //      _baseRequest<T>(uri, t, options: options, useSession: useSession);

  Future<HttpPipeline> _baseRequest<T>(String uri, HttpPipeline httpBuilder,
      {body}) async {
    final url = service + uri;
    final HttpPipeline http = httpBuilder.url(url).addBody(body).build();
    return await http.makeAsyncRequest();
  }
}
