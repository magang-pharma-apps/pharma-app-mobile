import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/inventory_item_model.dart';
import 'package:medpia_mobile/app/models/inventory_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/repositories/inventory_repository.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

class StockController extends GetxController {
  InventoryRepository inventoryRepository = InventoryRepository();
  Rx<InventoryModel> inventory = InventoryModel().obs;

  String formattedDate =
      DateFormat('dd/MM/yyyy hh:mm:ss a').format(DateTime.now());

  final productRepository = ProductRepository();
  RxList<ProductModel> products = <ProductModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();
    inventory.value.id = 0;
    inventory.value.inventoryDate = '';
    inventory.value.inventoryType = '';
    inventory.value.note = '';
    inventory.value.items = <InventoryItemModel>[];
  }

  void getProducts() async {
    final response = await productRepository.getProducts();
    products.value = response;
  }

  void removeMedicine(InventoryItemModel item) {
    final items = inventory.value.items!;
    final index =
        items.indexWhere((element) => element.product!.id == item.product!.id);
    print("index : $index");

    if (index >= 0) {
      items.removeAt(index);
      print("Removed item: ${item.product!.name}");
    }

    inventory.refresh();
  }

  void reduceQuantity(InventoryItemModel item) {
    final items = inventory.value.items!;
    final index =
        items.indexWhere((element) => element.product!.id == item.product!.id);
    print("index : $index");

    if (index >= 0) {
      if (items[index].quantity! > 1) {
        items[index].quantity = items[index].quantity! - 1;
        print("Reduced quantity for ${item.product!.name}");
      }
    }

    inventory.refresh();
  }

  void addMedicine(InventoryItemModel item) {
    final items = inventory.value.items!;
    final index =
        items.indexWhere((element) => element.product!.id == item.product!.id);
    print("index : $index");

    if (index >= 0) {
      // Jika produk sudah ada, tambahkan quantity
      items[index].quantity = (items[index].quantity ?? 0) + 1;
      print("Updated quantity for ${item.product!.name}");
    } else {
      // Jika produk belum ada, tambahkan sebagai item baru
      items.add(item);
      print("Added new item: ${item.product!.name}");
    }

    inventory.refresh();
  }

  void createStockIn() async {
    try {
      final isCreated = await inventoryRepository
          .createInventory(inventory.value.stockintoJson());

      if (isCreated) {
        CustomSnackbar.showSnackbar(Get.context!,
            message: "Stock In successfully created",
            title: 'Success!',
            contentType: ContentType.success);
      } else {
        CustomSnackbar.showSnackbar(Get.context!,
            message: "Failed to created stock in",
            title: "Failed!",
            contentType: ContentType.failure);
      }
    } catch (e) {
      print("Error Create StockIn");
    }
  }
}
