import 'dart:convert';

import 'package:medpia_mobile/app/models/customer_model.dart';
import 'package:medpia_mobile/app/providers/customer_provider.dart';

class CustomerRepository {
  CustomerProvider customerProvider = CustomerProvider();

  List<CustomerModel> customers = [];

  Future<List<CustomerModel>> getCustomers() async {
    final response = await customerProvider.getCustomers();
    // print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return data
          .map<CustomerModel>((json) => CustomerModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load customer ${response.statusCode}');
    }
  }

  Future<bool> createCustomer(Map<String, dynamic> body) async {
    try {
      final response = await customerProvider.createCustomer(body);
      // print(response.body);
      // print('status ${response.statusCode}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        final errorResponse = json.decode(response.body);
        throw Exception(
            'Failed to create customer: ${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to create customer: $e');
    }
  }
  

  Future<bool> deleteCustomer(int id) async {
     try {
      final response = await customerProvider.deleteCustomer(id);

      if (response.statusCode == 200) {
        return true;
      } else {
        final errorReponse = json.decode(response.body);
        throw Exception('Failed to delete customer: ${errorReponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to delete customer $e');
    }
  }
}
