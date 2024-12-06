import 'package:get/state_manager.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/repositories/category_repository.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

class CategoryController extends GetxController {
  CategoryRepository categoryRepository = CategoryRepository();
  ProductRepository productRepository = ProductRepository();

  Rx<ProductModel> products = ProductModel().obs;
  Rx<CategoryModel> category = CategoryModel().obs;

  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<ProductModel> productList = <ProductModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProducts().then((_) {
      getCategories();
    });
  }

  void getCategories({Map<String, dynamic>? query}) async {
    try {
      isLoading.value = true;
      final data = await categoryRepository.getCategories();

      categoryList.value = data;
    } catch (e) {
      print('Failed to load category $e');
    } finally {
      isLoading.value = false;
    }
    // logic untuk mendapatkan data category
  }

  getProductsByCategory(categoryId) {
    return productList
        .where((product) => product.category!.id == categoryId)
        .length;
  }

  Future<void> getProducts({
    Map<String, dynamic>? query,
  }) async {
    final data = await productRepository
        .getProducts(query: {'categoryId': category.value.id});
    productList.value = data;
  }

  
}
