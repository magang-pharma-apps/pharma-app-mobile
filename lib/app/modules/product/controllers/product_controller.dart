import 'package:get/get.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

class ProductController extends GetxController {
  String? categoryId = '';
  RxBool isLoading = false.obs;
  RxList<ProductModel> productList = <ProductModel>[].obs;
  Rx<CategoryModel> category = CategoryModel().obs;

  ProductRepository productRepository = ProductRepository();

  ProductController({this.categoryId = ''});

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  void getProducts() async {
    print('Coba liat argumentnya ${Get.arguments.toString()}');
    // logic untuk mendapatkan data product
    try {
      isLoading.value = true;
      final data = await productRepository
          .getProducts(query: {'categoryId': categoryId ?? ''});
      productList.value = data;
    } catch (e) {
      print('Failed to load product $e');
      // TODO
    } finally {
      isLoading.value = false;
    }
  }
}
