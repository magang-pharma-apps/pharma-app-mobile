import 'package:get_storage/get_storage.dart';
import 'package:medpia_mobile/app/providers/api_provider.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ApiProvider {

  CategoryProvider()
      : super(headers: {
          'Content-Type': 'application/json',
          'Authorization':'Bearer ${GetStorage().read('accessToken')}',
        });
  

  Future<http.Response> getCategories() async {
    final response = await get('categories');
    return response;
  }

  Future<http.Response> getCategoryById(String id) async {
    final response = await get('categories/$id');
    return response;
  }
}
