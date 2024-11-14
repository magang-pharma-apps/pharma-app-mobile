import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/repositories/customer_repository.dart';

class CustomerCreateController extends GetxController {
  final customerRepository = CustomerRepository();

  String? name;
  int? age;
  String? address;

  void createCustomer() async {
    try {
      await customerRepository.createCustomer({
        'name': name,
        'age': age,
        'address': address,
      });
      Get.back(result: true);
      CustomSnackbar.showSnackbar(Get.context!,
          title: 'Success!',
          message: 'Customer created successfully',
          contentType: ContentType.success);
    } catch (e) {
      CustomSnackbar.showSnackbar(Get.context!,
          title: 'Failed!',
          message: 'Failed to create customer. Something went wrong',
          contentType: ContentType.failure);
      throw Exception(e);
    }
  }
}
