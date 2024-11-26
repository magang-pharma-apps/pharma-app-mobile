import 'package:get/get.dart';
import 'package:medpia_mobile/app/models/inventory_item_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/stock/controllers/stock_controller.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

class StockMedicineListController extends GetxController {
  final productRepository = ProductRepository();

  final stockController = Get.find<StockController>();
  RxList<ProductModel> products = <ProductModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();
  }

  void getProducts() async {
    final response = await productRepository.getProducts();
    products.value = response;
  }

  void addMedicine(InventoryItemModel item) {
    final items = stockController.inventory.value.items!;
    final index =
        items.indexWhere((element) => element.product!.id == item.product!.id);
    // print("index : $index");

    if (index >= 0) {
      // Jika produk sudah ada, tambahkan quantity
      items[index].quantity =
          (items[index].quantity ?? 0) + (item.quantity ?? 0);
      print("Updated quantity for ${item.product!.name}");
    } else {
      // Jika produk belum ada, tambahkan sebagai item baru
      items.add(item);
      print("Added new item: ${item.product!.name}");
    }

    stockController.inventory.refresh();
  }

}
