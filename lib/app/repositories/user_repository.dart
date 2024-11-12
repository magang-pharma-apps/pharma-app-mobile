import 'dart:convert';

import 'package:medpia_mobile/app/models/user_model.dart';
import 'package:medpia_mobile/app/providers/user_provider.dart';

class UserRepository {
  final userProvider = UserProvider();

  Future<List<UserModel>> getUsers() async {
    final response = await userProvider.getUsers();
    // print(response.body);
    // print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return data.map<UserModel>((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user ${response.statusCode}');
    }
  }

}