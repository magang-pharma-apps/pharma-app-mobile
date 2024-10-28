import 'dart:convert';

import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/providers/product_provider.dart';

class ProductRepository {
  ProductProvider productProvider = ProductProvider();

  List<ProductModel> products = [];

  Future<List<ProductModel>> getProducts() async {
    final response = await productProvider.getProducts();
    print(response.body);
    // print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return data
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load product ${response.statusCode}');
    }
  }

  getProduct() {}
}
