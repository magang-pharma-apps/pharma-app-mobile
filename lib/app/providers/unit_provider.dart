import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medpia_mobile/app/providers/api_provider.dart';

class UnitProvider extends ApiProvider {
  UnitProvider()
      : super(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('accessToken')}'
        });

  Future<http.Response> getUnits() async {
    final response = await get('units');
    return response;
  }

  Future<http.Response> getUnitById(int id) async {
    final response = await get('units/$id');
    return response;
  }

  Future<http.Response> createUnit(Map<String, dynamic> body) async {
    final response = await post('units', body);
    return response;
  }

  Future<http.Response> deleteUnit(int id) async {
    final response = await delete('units/$id');
    return response;
  }

  Future<http.Response> updateUnit(int id, Map<String, dynamic> body) async {
    final response = await patch('units/$id', body);
    return response;
  }
}
