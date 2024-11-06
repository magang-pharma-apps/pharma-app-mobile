import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medpia_mobile/app/providers/api_provider.dart';

class PrescriptionProvider extends ApiProvider {
  PrescriptionProvider()
      : super(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('accessToken')}'
        });
  

  Future<http.Response> getPrescriptions() async {
    final response = await get('prescriptions');
    return response;
  }

  Future<http.Response> getPrescriptionById(String id) async {
    final response = await get('prescriptions/$id');
    return response;
  }

  Future<http.Response> createPrescriptions(Map<String, dynamic> body) async {
    final response = await post('prescriptions', body);
    return response;
  }

  Future<http.Response> createRedemption(Map<String, dynamic> body) async {
    final response = await post('prescription-redemptions', body);
    
    return response;
  }
}
