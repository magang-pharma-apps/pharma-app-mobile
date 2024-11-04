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

  getCustomer() {}
}
