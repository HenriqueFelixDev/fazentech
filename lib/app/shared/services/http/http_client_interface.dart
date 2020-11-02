typedef HttpRequestErrorCallback = void Function(int statusCode, dynamic body);
abstract class IHttpClient {
  String baseUrl;
  Map<String, String> defaultHeaders;

  Future get(String url, {Map<String, String> headers, HttpRequestErrorCallback onError, bool useBaseUrl});
  Future post(String url, {Map<String, String> headers, dynamic body, HttpRequestErrorCallback onError, bool useBaseUrl});
  Future put(String url, {Map<String, String> headers, dynamic body, HttpRequestErrorCallback onError, bool useBaseUrl});
  Future delete(String url, {Map<String, String> headers, HttpRequestErrorCallback onError, bool useBaseUrl});
}