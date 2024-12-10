import 'dart:convert';

import 'package:medpia_mobile/app/models/inventory_model.dart';
import 'package:medpia_mobile/app/providers/inventory_provider.dart';

class InventoryRepository {
  InventoryProvider inventoryProvider = InventoryProvider();

  Future<List<InventoryModel>> getInventories(
      {Map<String, dynamic>? query}) async {
    final response = await inventoryProvider.getInventories(query: query);
    // print(response.body);
    // print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return data
          .map<InventoryModel>((json) => InventoryModel.inventoryFromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load inventory ${response.statusCode}');
    }
  }

  Future<InventoryModel> getInventoryById(int id) async {
    final response = await inventoryProvider.getInventoryById(id);
    // print(response.body);
    // print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return InventoryModel.inventoryFromJson(data);
    } else {
      throw Exception('Failed to load inventory ${response.statusCode}');
    }
  }

  Future<bool> createInventory(Map<String, dynamic> body) async {
    try {
      final response = await inventoryProvider.createInventory(body);

      // print('createInventory body :${response.body}');
      // print('createInventory : ${response.statusCode}');

      if (response.statusCode == 201) {
        return true;
      } else {
        final errorResponse = json.decode(response.body);
        throw Exception(
            'Failed to create inventory: ${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to create inventory: $e');
    }
  }

  Future<bool> createOpname(Map<String, dynamic> body) async {
    try {
      final response = await inventoryProvider.createOpname(body);
      print('createOpname body :${response.body}');
      print('createOpname : ${response.statusCode}');

      if (response.statusCode == 201) {
        return true;
      } else {
        final errorResponse = json.decode(response.body);
        throw Exception('Failed to create opname: ${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to create opname: $e');
    }
  }
}
