import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart'as http;
import 'package:medpia_mobile/app/providers/api_provider.dart';

class UnitProvider extends ApiProvider {
  UnitProvider()
      : super(headers: {
          'Content-Type': 'application/json',
          'Authprization': 'Bearer ${GetStorage().read('accessToken')}'
        });

  Future<http.Response> getUnits() async {
    final response = await get('units');
    return response;
  }

  Future<http.Response> getUnitById(String id) async {
    final response = await get('units/$id');
    return response;
  }
}
