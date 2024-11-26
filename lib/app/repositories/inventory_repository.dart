import 'dart:convert';

import 'package:medpia_mobile/app/models/inventory_item_model.dart';
import 'package:medpia_mobile/app/models/inventory_model.dart';
import 'package:medpia_mobile/app/providers/inventory_provider.dart';

class InventoryRepository {
  InventoryProvider inventoryProvider = InventoryProvider();

  Future<List<InventoryModel>> getInventories() async {
    final response = await inventoryProvider.getInventories();
    // print(response.body);

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

  Future<bool> createInventory(Map<String, dynamic> body) async {
    try {
      final response = await inventoryProvider.createInventory(body);
      print(response.body);
      print('status ${response.statusCode}');

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to create inventory: $e');
    }
  }
}
