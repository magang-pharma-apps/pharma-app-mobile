import 'package:get/get.dart';
import 'package:medpia_mobile/app/models/customer_model.dart';
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
}
