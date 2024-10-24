import 'package:http/http.dart' as http;

abstract class BaseProvider {
  Future<http.Response> get(String endpoint);
  Future<http.Response> post(String endpoint, Map<String, dynamic> body);
  Future<http.Response> put(String endpoint, Map<String, dynamic> body);
  Future<http.Response> patch(String endpoint, Map<String, dynamic> body);
  Future<http.Response> delete(String endpoint);

  String getUrl(String url);
}
