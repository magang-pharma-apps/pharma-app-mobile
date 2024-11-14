import 'package:get/get.dart';
import 'package:medpia_mobile/app/models/unit_model.dart';
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


}