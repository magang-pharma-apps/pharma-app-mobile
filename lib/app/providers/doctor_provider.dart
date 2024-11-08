import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medpia_mobile/app/providers/api_provider.dart';

class DoctorProvider extends ApiProvider {
  DoctorProvider()
      : super(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('accessToken')}'
        });

  Future<http.Response> getDoctors() async {
    final response = await get('doctors');
    return response;
  }

  Future<http.Response> getDoctorById(String id) async {
    final response = await get('doctors/$id');
    return response;
  }
}
