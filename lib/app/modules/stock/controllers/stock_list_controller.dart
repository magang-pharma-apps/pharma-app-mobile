import 'package:get/state_manager.dart';
import 'package:medpia_mobile/app/models/inventory_model.dart';
import 'package:medpia_mobile/app/repositories/inventory_repository.dart';

class StockListController extends GetxController {
  final inventoryRepository = InventoryRepository();
  RxList<InventoryModel> inventoryList = <InventoryModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getInventories();
  }

  void getInventories() async {
    try {
      isLoading.value = true;
      final response = await inventoryRepository.getInventories();
      inventoryList.value = response;
    } catch (e) {
      // TODO
      print('Failed to load inventory$e');
    } finally {
      isLoading.value = false;
    }
  }
}
