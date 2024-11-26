import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:medpia_mobile/app/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class ApiProvider implements BaseProvider {
  // String? baseUrl = 'http://192.168.1.2:3000';
  String? baseUrl = 'http://192.168.51.234:3000'; //HP
  // String? baseUrl = 'http://192.168.1.11:3000'; //

  Map<String, String>? headers = {'Content-Type': 'application/json'};
  final storage = GetStorage();

  ApiProvider({this.headers});

  @override
  Future<http.Response> get(
    String endpoint,
  ) async {
    try {
      final url = getUrl(endpoint);

      final response = await http.get(Uri.parse(url), headers: headers);

      return response;
    } catch (e) {
      throw ('Error Get Data $e');
    }
  }

  @override
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final url = getUrl(endpoint);

      return await http.post(Uri.parse(url),
          body: jsonEncode(body), headers: headers);
    } catch (e) {
      throw ('Error Post Data $e');
    }
  }

  @override
  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final url = getUrl(endpoint);

      return await http.put(Uri.parse(url),
          body: jsonEncode(body), headers: headers);
    } catch (e) {
      throw ('Error Put Data $e');
    }
  }

  @override
  Future<http.Response> patch(
      String endpoint, Map<String, dynamic> body) async {
    try {
      final url = getUrl(endpoint);

      return await http.patch(Uri.parse(url),
          body: jsonEncode(body), headers: headers);
    } catch (e) {
      throw ('Error Patch Data $e');
    }
  }

  @override
  Future<http.Response> delete(String endpoint) async {
    try {
      final url = getUrl(endpoint);

      return await http.delete(Uri.parse(url), headers: headers);
    } catch (e) {
      throw ('Error Delete Data $e');
    }
  }

  @override
  getUrl(String url) {
    return '$baseUrl/$url';
  }
}
