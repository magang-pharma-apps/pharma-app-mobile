import 'package:get_storage/get_storage.dart';
import 'package:medpia_mobile/app/providers/api_provider.dart';

class CustomerProvider extends ApiProvider {
  CustomerProvider()
      : super(headers: {
          'Content-Type': 'application/json',
          'Autorization': 'Bearer ${GetStorage().read('accessToken')}'
        });

  Future getCustomers() async {
    final response = await get('customers');
    return response;
  }

  Future getCustomerById(String id) async {
    final response = await get('customers/$id');
    return response;
  }
}
