import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medpia_mobile/app/providers/api_provider.dart';

class CustomerProvider extends ApiProvider {
  CustomerProvider()
      : super(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('accessToken')}'
        });

  Future<http.Response> getCustomers() async {
    final response = await get('customers');
    return response;
  }

  Future<http.Response> getCustomerById(int id) async {
    final response = await get('customers/$id');
    return response;
  }

  Future<http.Response> createCustomer(Map<String, dynamic> body) async {
    final response = await post('customers', body);
    return response;
  }

  Future<http.Response> deleteCustomer(int id) async {
    final response = await delete('customers/$id');
    return response;
  }

  Future<http.Response> updateCustomer(int id, Map<String, dynamic> body) async {
    final response = await patch('customers/$id', body);
    return response;
  }
}
