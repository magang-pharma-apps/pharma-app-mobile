import 'dart:convert';

import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/providers/product_provider.dart';

class ProductRepository {
  ProductProvider productProvider = ProductProvider();

  List<ProductModel> products = [];

  Future<List<ProductModel>> getProducts({Map<String, dynamic>? query}) async {
    final response = await productProvider.getProducts(query: query);
    // print(response.body);
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

  Future<ProductModel> getProductById(int id) async {
    final response = await productProvider.getProductById(id);
    // print(response.body);
    // print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return ProductModel.fromJson(data);
    } else {
      throw Exception('Failed to load product ${response.statusCode}');
    }
  }

  Future<bool> createProduct(Map<String, dynamic> body) async {
    try {
      final response = await productProvider.createProduct(body);
      // print(response.body);
      // print('status ${response.statusCode}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        final errorResponse = json.decode(response.body);
        throw Exception(
            'Failed to create product: ${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }

  Future<bool> deleteProductById(int id) async {
    try {
      final response = await productProvider.deleteProductById(id);
      // print(response.body);
      // print('status ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        final errorResponse = json.decode(response.body);
        throw Exception(
            'Failed to delete product: ${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  Future<bool> updateProductById(int id, Map<String, dynamic> body) async {
    try {
      final response = await productProvider.updateProduct(id, body);
      // print(response.body);
      // print('status ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final errorResponse = json.decode(response.body);
        throw Exception(
            'Failed to update product: ${errorResponse['message']}');
      }
    } catch (e) {
      print('error update product $e');
      throw Exception('Failed to update product: $e');
    }
  }
}
