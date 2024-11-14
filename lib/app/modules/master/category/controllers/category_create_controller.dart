import 'package:get/get.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/repositories/category_repository.dart';

class CategoryCreateController extends GetxController {
  final categoryRepository = CategoryRepository();

  String? name;
  String? description;
  String? categoryImageUrl;

  void createCategory() async {
    try {
      await categoryRepository.createCategory({
        'name': name,
        'description': description ?? '',
        'categoryImageUrl': categoryImageUrl
      });
      Get.back(result: true);

      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Success!',
        message: 'Category created successfully',
      );
    } catch (e) {
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Failed!',
        message: 'Failed to create category. Something went wrong',
      );
    }
  }
}
