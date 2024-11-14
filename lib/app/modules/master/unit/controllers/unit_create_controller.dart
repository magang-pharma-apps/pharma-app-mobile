import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/repositories/unit_repository.dart';

class UnitCreateController extends GetxController {
  final unitRepository = UnitRepository();

  String? name;
  String? description;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void createUnit() async {
    isLoading.value = true;
    try {
      await unitRepository.createUnit({
        'name': name,
        'description': description ?? '',
      });
      isLoading.value = false;
      Get.back(result: true);

      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Success!',
        message: 'Unit created successfully',
        contentType: ContentType.success,
      );
    } catch (e) {
      isLoading.value = false;
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Failed!',
        message: 'Failed to create unit. Something went wrong',
        contentType: ContentType.failure,
      );
    }
  }
}
