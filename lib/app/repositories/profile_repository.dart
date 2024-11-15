import 'dart:convert';

import 'package:medpia_mobile/app/models/profile_model.dart';
import 'package:medpia_mobile/app/providers/profile_provider.dart';

class ProfileRepository {
  final profileProvider = ProfileProvider();

  ProfileModel profile = ProfileModel();

  Future<ProfileModel> getProfile() async {
    final response = await profileProvider.getProfile();
    // print(response.body);
    // print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      // print('datav : ${data}');
      return ProfileModel.fromJson(data);
    } else {
      throw Exception('Failed to load profile ${response.statusCode}');
    }
  }
}