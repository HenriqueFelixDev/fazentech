import 'http_client_interface.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

typedef HttpOnRequestCallback = Future<http.Response> Function(String url, Map<String, String> headers, Map<String, String> body);

class HttpClientImpl implements IHttpClient {
  @override
  String baseUrl;

  @override
  Map<String, String> defaultHeaders;

  HttpClientImpl({this.baseUrl = '', this.defaultHeaders = const {}});

  void _concatHeadersWithDefaultHeaders(Map<String, String> headers) {
    if(headers == null) {
      headers = defaultHeaders;
      return;
    }
    headers.addAll(defaultHeaders);
  }

  String _getFullUrl(String url) {
    if(baseUrl == null || baseUrl.isEmpty) {
      return url;
    }

    url = url.replaceFirst('/', '');
    return '$baseUrl/$url';
  }

  dynamic _handleResponse(http.Response response, HttpRequestErrorCallback onError) {
    if(response.statusCode >= 200 && response.statusCode < 300) {
      if(response.body.trim().isEmpty) {
        return null;
      }
      return json.decode(response.body);
    }

    if(response.statusCode >= 400) {
      onError?.call(response.statusCode, response.body);
    }

    return null;
  }

  Future _handleRequest(String url, HttpOnRequestCallback onRequest, {
    Map<String, String> headers, 
    dynamic body, 
    HttpRequestErrorCallback onError, 
    bool useBaseUrl
  }) async{
    useBaseUrl = useBaseUrl ?? true;
    _concatHeadersWithDefaultHeaders(headers);

    final response = await onRequest(
      useBaseUrl
        ? _getFullUrl(url)
        : url, 
        headers, body
    );

    return _handleResponse(response, onError);
  }

  @override
  Future get(String url, {
    Map<String, String> headers, 
    HttpRequestErrorCallback onError, 
    bool useBaseUrl
  }) async{
    return _handleRequest(
      url,
      (fullUrl, headers, body) => http.get(fullUrl, headers: headers),
      headers: headers,
      onError: onError,
      useBaseUrl: useBaseUrl
    );
  }

  @override
  Future post(String url, {
    Map<String, String> headers, 
    dynamic body, 
    HttpRequestErrorCallback onError, 
    bool useBaseUrl
  }) async{
    return _handleRequest(
      url,
      (fullUrl, headers, body) => http.post(fullUrl, headers: headers, body: body),
      headers: headers,
      body: body,
      onError: onError,
      useBaseUrl: useBaseUrl
    );
  }

  @override
  Future delete(String url, {
    Map<String, String> headers, 
    HttpRequestErrorCallback onError, 
    bool useBaseUrl
  }) async{
    return _handleRequest(
      url,
      (fullUrl, headers, body) => http.delete(fullUrl, headers: headers),
      headers: headers,
      onError: onError,
      useBaseUrl: useBaseUrl
    );
  }
  
  @override
  Future put(String url, {
    Map<String, String> headers, 
    dynamic body, HttpRequestErrorCallback onError, 
    bool useBaseUrl
  }) async{
    return _handleRequest(
      url,
      (fullUrl, headers, body) => http.put(fullUrl, headers: headers, body: body),
      headers: headers,
      body: body,
      onError: onError,
      useBaseUrl: useBaseUrl
    );
  }

}