import 'package:get_storage/get_storage.dart';
import 'package:medpia_mobile/app/providers/api_provider.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ApiProvider {
  ProductProvider()
      : super(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('accessToken')}',
        });

  Future<http.Response> getProducts() async {
    final response = await get('products');
    return response;
  }

  Future<http.Response> getProductById(int id) async {
    final response = await get('products/$id');
    return response;
  }

  Future<http.Response> createProduct(Map<String, dynamic> body) async {
    final response = await post('products', body);
    return response;
  }

  Future<http.Response> deleteProductById(int id) async {
    final response = await delete('products/$id');
    return response;
  }

  Future<http.Response> updateProductById(int id, Map<String, dynamic> body) async {
    final response = await patch('products/$id', body);
    return response;
  }
}
