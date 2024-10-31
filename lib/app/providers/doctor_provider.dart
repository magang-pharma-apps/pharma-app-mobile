import 'package:get_storage/get_storage.dart';
import 'package:medpia_mobile/app/providers/api_provider.dart';

class DoctorProvider extends ApiProvider {
  DoctorProvider()
      : super(headers: {
          'Content-Type': 'application/json',
          'Autorization': 'Bearer ${GetStorage().read('accessToken')}'
        });

  Future getDoctors() async {
    final response = await get('doctors');
    return response;
  }

  Future getDoctorById(String id) async {
    final response = await get('doctors/$id');
    return response;
  }
}
