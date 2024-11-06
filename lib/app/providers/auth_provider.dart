import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medpia_mobile/app/providers/api_provider.dart';

class AuthProvider extends ApiProvider {
  AuthProvider()
      : super(
          headers: {'Content-Type': 'application/json'},
        );

  Future<http.Response> login(String username, String password) async {
    try {
      final response = await post(
          'auth/login', {"username": username, "password": password});
      // print(response.body);
      // print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = json.decode(response.body)['accessToken'];
        final storage = GetStorage();
        storage.write('accessToken', token);
        storage.write('isLogin', true);
        storage.write('userId', json.decode(response.body)['data']['id']);
        storage.write(
            'username', json.decode(response.body)['data']['username']);
      } else {
        storage.write('isLogin', false);
      }
      return response;
    } catch (e) {
      throw ('Error Login $e');
    }
  }
}
