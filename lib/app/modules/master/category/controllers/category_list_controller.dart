import 'package:get/get.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/repositories/category_repository.dart';

class CategoryListController extends GetxController{

  final categoryRepository = CategoryRepository();

  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  void getCategories() async {
    try{
      isLoading.value = true;
      final response = await categoryRepository.getCategories();
      categories.value = response;

    }catch(e){
      throw Exception('Failed to load categories: $e');
    } finally {
      isLoading.value = false;
    }
  }
}