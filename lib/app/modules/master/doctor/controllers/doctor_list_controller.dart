import 'package:get/get.dart';
import 'package:medpia_mobile/app/models/doctor_model.dart';
import 'package:medpia_mobile/app/repositories/doctor_repository.dart';

class DoctorListController extends GetxController {
  final doctorRepository = DoctorRepository();

  RxList<DoctorModel> doctors = <DoctorModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getDoctors();
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
}
