import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/customer_model.dart';
import 'package:medpia_mobile/app/modules/master/customer/views/customer_list_view.dart';
import 'package:medpia_mobile/app/repositories/customer_repository.dart';

class CustomerListController extends GetxController {
  final customerRepository = CustomerRepository();

  RxList<CustomerModel> customers = <CustomerModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCustomers();
  }

  void getCustomers() async {
    try {
      isLoading.value = true;
      final response = await customerRepository.getCustomers();
      customers.value = response;
      // print(response);
    } catch (e) {
      throw Exception('Failed to load customers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void deleteCustomer(int id) async {
    try {
      isLoading.value = true;
      final response = await customerRepository.deleteCustomer(id);
      if (response == true) {
        getCustomers();
      }
      int count = 0;
      Get.until((route) {
        count++;
        return count == 2; // Stop after going back two pages
      });
      CustomSnackbar.showSnackbar(Get.context!,
          title: 'Success!',
          message: 'Customer deleted successfully',
          contentType: ContentType.success);
    } catch (e) {
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Failed!',
        message: 'Failed to delete Customer',
        contentType: ContentType.failure,
      );
      throw Exception('Failed to delete Customer: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
