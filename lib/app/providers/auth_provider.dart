import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medpia_mobile/app/providers/api_provider.dart';

class AuthProvider extends ApiProvider {
  AuthProvider() : super();

  Future<http.Response> login(String username, String password) async {
    try {
      final response = await post(
          'auth/login', {"username": username, "password": password});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = json.decode(response.body)['accessToken'];
        final storage = GetStorage();
        storage.write('accessToken', token);
        storage.write('isLogin', true);
      } else {
        storage.write('isLogin', false);
      }
      return response;
    } catch (e) {
      throw ('Error Login $e');
    }
  }
}
