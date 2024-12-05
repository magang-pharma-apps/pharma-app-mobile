import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medpia_mobile/app/providers/api_provider.dart';

class InventoryProvider extends ApiProvider {
  InventoryProvider()
      : super(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('accessToken')}'
        });

  Future<http.Response> getInventories({Map<String, dynamic>? query}) async {
    final response = await get('inventories', query: query);
    return response;
  }

  Future<http.Response> getInventoryById(int id) async {
    final response = await get('inventories/$id');
    return response;
  }

  Future<http.Response> createInventory(Map<String, dynamic> body) async {
    final response = await post('inventories', body);
    return response;
  }

  Future<http.Response> getInventoryByType(String type) async {
    final response = await get('inventories?inventoryType=$type');
    return response;
  }
}
