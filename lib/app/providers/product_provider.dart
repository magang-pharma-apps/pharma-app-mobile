import 'package:get_storage/get_storage.dart';
import 'package:medpia_mobile/app/providers/api_provider.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ApiProvider {

  ProductProvider()
      : super(headers: {
          'Content-Type': 'application/json',
          'Authorization':'Bearer ${GetStorage().read('accessToken')}',
        });
  

  Future<http.Response> getProducts() async {
    final response = await get('products');
    return response;
  }

  Future<http.Response> getProductById(String id) async {
    final response = await get('products/$id');
    return response;
  }
}
