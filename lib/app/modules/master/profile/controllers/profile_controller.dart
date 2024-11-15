import 'package:get/get.dart';
import 'package:medpia_mobile/app/models/profile_model.dart';
import 'package:medpia_mobile/app/repositories/profile_repository.dart';

class ProfileController extends GetxController {
  final profileRepository = ProfileRepository();

  Rx<ProfileModel> profile = ProfileModel().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  void getProfile() async {
    try {
      isLoading.value = true;

      final response = await profileRepository.getProfile();
      profile.value = response;
      // print('Profile data loaded: ${profile.value}');
    } catch (e) {
      // print('Error loading profile: $e');
      throw Exception('Failed to load profile: $e');
// Add error logging
    } finally {
      isLoading.value = false;
    }
  }
}
