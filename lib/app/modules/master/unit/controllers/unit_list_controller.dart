import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/unit_model.dart';
import 'package:medpia_mobile/app/repositories/unit_repository.dart';

class UnitListController extends GetxController {
  final unitRepository = UnitRepository();

  RxList<UnitModel> units = <UnitModel>[].obs;
  Rx<UnitModel>? unitModel = UnitModel().obs;

  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;

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

  void getUnitbyId(int id) async {
    try {
      isLoading.value = true;
      await unitRepository.getUnitById(id);
    } catch (e) {
      throw Exception('Failed to load unit: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleEdit(bool value, int unitId) {
    isEdit.value = value;
    if (value == true) {
      loadUnit(unitId);
    }
  }

  void loadUnit(int id) async {
    try {
      isLoading.value = true;
      final unit = await unitRepository.getUnitById(id);
      unitModel!.value = unit;
    } catch (e) {
      throw Exception('Failed to load unit: $e');
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

  void updateUnit(int id) async {
    isLoading.value = true;
    try {
      print('unitModel!.value.toJson(): ${unitModel!.value.toJson()}');
      await unitRepository.updateUnit(id, unitModel!.value.toJson());
      isLoading.value = false;
      Get.back(result: true);
      getUnits();
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Success!',
        message: 'Product unit successfully',
        contentType: ContentType.success,
      );
    } catch (e) {
      isLoading.value = false;
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Failed!',
        message: 'Failed to update unit',
        contentType: ContentType.failure,
      );
      print('Error update product$e');

      throw Exception('Failed to update unit: $e');
    }
  }
}
