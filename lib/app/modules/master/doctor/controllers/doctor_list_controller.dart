import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/doctor_model.dart';
import 'package:medpia_mobile/app/modules/master/doctor/views/doctor_list_view.dart';
import 'package:medpia_mobile/app/repositories/doctor_repository.dart';

class DoctorListController extends GetxController {
  final doctorRepository = DoctorRepository();

  RxList<DoctorModel> doctors = <DoctorModel>[].obs;
  Rx<DoctorModel>? doctorModel = DoctorModel().obs;

  RxBool isEditing = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getDoctors();
  }

  void toggleEdit(bool value, int doctorId) {
    isEditing.value = value;
    if (value == true) {
      loadDoctor(doctorId);
    }
  }

  void getDoctors() async {
    try {
      isLoading.value = true;
      final response = await doctorRepository.getDoctors();
      doctors.value = response;
    } catch (e) {
      throw Exception('Failed to load doctors: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void getDoctorById(int id) async {
    try {
      isLoading.value = true;
      final response = await doctorRepository.getDoctorById(id);
      doctorModel!.value = response;
    } catch (e) {
      throw Exception('Failed to load doctor: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadDoctor(int id) async {
    try {
      isLoading.value = true;
      final response = await doctorRepository.getDoctorById(id);
      doctorModel!.value = response;
    } catch (e) {
      throw Exception('Failed to load doctor: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateDoctor(int id) async {
    try {
      isLoading.value = true;
      await doctorRepository.updateDoctor(id, doctorModel!.value.toJson());

      Get.back(result: true);
      getDoctors();

      CustomSnackbar.showSnackbar(Get.context!,
          title: 'Success!',
          message: 'Doctor updated successfully',
          contentType: ContentType.success);
    } catch (e) {
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Failed!',
        message: 'Failed to update doctor',
        contentType: ContentType.failure,
      );
      throw Exception('Failed to update doctor: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void deleteDoctor(int id) async {
    try {
      isLoading.value = true;
      final response = await doctorRepository.deleteDoctor(id);
      if (response == true) {
        getDoctors();
      }
      int count = 0;
      Get.until((route) {
        count++;
        return count == 2; // Stop after going back two pages
      });
      CustomSnackbar.showSnackbar(Get.context!,
          title: 'Success!',
          message: 'Doctor deleted successfully',
          contentType: ContentType.success);
    } catch (e) {
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Failed!',
        message: 'Failed to delete doctor',
        contentType: ContentType.failure,
      );
      throw Exception('Failed to delete doctor: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
