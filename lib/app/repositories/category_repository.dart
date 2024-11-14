import 'dart:convert';

import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/providers/category_provider.dart';

class CategoryRepository {
  CategoryProvider categoryProvider = CategoryProvider();

  List<CategoryModel> categories = [];

  Future<List<CategoryModel>> getCategories() async {
    final response = await categoryProvider.getCategories();
    // print(response.body);
    // print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return data
          .map<CategoryModel>((json) => CategoryModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load category ${response.statusCode}');
    }
  }

  Future<bool> createCategory(Map<String, dynamic> body) async {
    try {
      final response = await categoryProvider.createCategory(body);
      // print(response.body);
      // print('status ${response.statusCode}');

      if (response.statusCode == 201) {
        return true;
      } else {
        final errorResponse = json.decode(response.body);
        throw Exception(
            'Failed to create category: ${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to create category: $e');
    }
  }
}
