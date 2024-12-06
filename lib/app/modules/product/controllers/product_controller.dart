import 'package:get/get.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

class ProductController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ProductModel> productList = <ProductModel>[].obs;

  ProductRepository productRepository = ProductRepository();

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  void getProducts({Map<String, dynamic>? query}) async {
    // logic untuk mendapatkan data product
    try {
      isLoading.value = true;
      final data = await productRepository.getProducts();
      productList.value = data;
    } catch (e) {
      print('Failed to load product $e');
      // TODO
    } finally {
      isLoading.value = false;
    }
  }
}
