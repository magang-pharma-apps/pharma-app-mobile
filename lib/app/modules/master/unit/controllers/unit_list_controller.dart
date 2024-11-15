import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/unit_model.dart';
import 'package:medpia_mobile/app/modules/master/unit/views/unit_list_view.dart';
import 'package:medpia_mobile/app/repositories/unit_repository.dart';

class UnitListController extends GetxController {
  final unitRepository = UnitRepository();

  RxList<UnitModel> units = <UnitModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUnits();
  }

  void getUnits() async {
    try {
      isLoading.value = true;
      final response = await unitRepository.getUnits();
      units.value = response;
    } catch (e) {
      throw Exception('Failed to load units: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void deleteUnit(int id) async {
    try {
      await unitRepository.deleteUnit(id);

      int count = 0;
      Get.until((route) {
        count++;
        return count == 2; // Stop after going back two pages
      });
      getUnits();

      CustomSnackbar.showSnackbar(Get.context!,
          title: 'Success!',
          message: 'Unit deleted successfully',
          contentType: ContentType.success);
    } catch (e) {
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Failed!',
        message: 'Failed to delete unit',
        contentType: ContentType.failure,
      );
    }
  }
}
