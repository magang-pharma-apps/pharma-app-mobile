import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/repositories/doctor_repository.dart';

class DoctorCreateController extends GetxController {
  final doctorRepository = DoctorRepository();

  String? name;
  String? specialization;
  String? phoneNumber;
  String? email;

  void createDoctor() async {
    try {
      await doctorRepository.createDoctor({
        'name': name,
        'specialization': specialization,
        'phoneNumber': phoneNumber,
        'email': email
      });
      Get.back(result: true);

      CustomSnackbar.showSnackbar(Get.context!,
          title: 'Success!',
          message: 'Doctor has been created',
          contentType: ContentType.success);
    } catch (e) {
      CustomSnackbar.showSnackbar(Get.context!,
          title: 'Failed!',
          message: 'Failed to create doctor',
          contentType: ContentType.failure);
      // TODO
    }
  }
}
