import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medpia_mobile/app/providers/api_provider.dart';

class UserProvider extends ApiProvider {
  UserProvider()
      : super(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('accessToken')}'
        });

  Future<http.Response> getUsers() async {
    final response = await get('users');
    return response;
  }

  Future<http.Response> getUserById(String id) async {
    final response = await get('users/$id');
    return response;
  }
}
