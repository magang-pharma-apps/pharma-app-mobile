import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/modules/master/category/views/category_list_view.dart';
import 'package:medpia_mobile/app/repositories/category_repository.dart';

class CategoryListController extends GetxController {
  final categoryRepository = CategoryRepository();

  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  Rx<CategoryModel>? categoryModel = CategoryModel().obs;

  RxBool isLoading = false.obs;

  RxBool isEdit = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  void toggleEdit(bool value, int categoryId) {
    isEdit.value = value;
    if (value == true) {
      loadCategory(categoryId);
    }
  }

  void getCategories() async {
    try {
      isLoading.value = true;
      final response = await categoryRepository.getCategories();
      categories.value = response;
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void getCategoryById(int id) async {
    isLoading.value = true;
    try {
      final response = await categoryRepository.getCategoryById(id);
      categoryModel!.value = response;
    } catch (e) {
      throw Exception('Failed to load category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void deleteCategory(int id) async {
    try {
      await categoryRepository.deleteCategories(id);
      int count = 0;
      Get.until((route) {
        count++;
        return count == 2; // Stop after going back two pages
      });
      getCategories();
      CustomSnackbar.showSnackbar(Get.context!,
          title: 'Success!',
          message: 'Category deleted successfully',
          contentType: ContentType.success);
    } catch (e) {
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Failed!',
        message: 'Failed to delete category',
        contentType: ContentType.failure,
      );
    }
  }

  void loadCategory(int categoryId) async {
    try {
      isLoading.value = true;
      final category = await categoryRepository.getCategoryById(categoryId);
      categoryModel!.value = category;
    } catch (e) {
      throw Exception('Failed to load category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateCategory(int id) async {
    try {
      await categoryRepository.updateCategory(
          id, categoryModel!.value.toJson());
      isLoading.value = false;
      Get.back(result: true);
      getCategories();
      CustomSnackbar.showSnackbar(Get.context!,
          title: 'Success!',
          message: 'Category updated successfully',
          contentType: ContentType.success);
    } catch (e) {
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Failed!',
        message: 'Failed to update category',
        contentType: ContentType.failure,
      );
    }
  }
}
