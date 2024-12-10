import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/inventory_item_model.dart';
import 'package:medpia_mobile/app/models/inventory_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/repositories/inventory_repository.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

class StockController extends GetxController {
  InventoryRepository inventoryRepository = InventoryRepository();
  Rx<InventoryModel> inventory = InventoryModel().obs;

  var selectedDateTime = DateTime.now().obs;

  String get formattedDateTime =>
      DateFormat('dd/MM/yyyy hh:mm a').format(selectedDateTime.value);

  String get formattedDate =>
      DateFormat('dd/MM/yyyy').format(selectedDateTime.value);

  final productRepository = ProductRepository();
  RxList<ProductModel> products = <ProductModel>[].obs;

  RxList<InventoryModel> inventoryList = <InventoryModel>[].obs;

  RxList<InventoryModel> stockOutList = <InventoryModel>[].obs;

  RxList<InventoryModel> stockInList = <InventoryModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isShow = false.obs;

  RxList<ProductModel> selectedItems =
      <ProductModel>[].obs; // Daftar item yang dipilih

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();
    getInventories();

    inventory.value.id = 0;
    inventory.value.inventoryDate = formattedDateTime;
    inventory.value.inventoryType = '';
    inventory.value.reasonType = '';
    inventory.value.note = '';
    inventory.value.items = <InventoryItemModel>[];
  }

  // Fungsi untuk memilih tanggal
  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime.value,
      firstDate: DateTime(2000), // Tanggal awal
      lastDate: DateTime.now(), // Tanggal sekarang
    );

    if (pickedDate != null) {
      selectedDateTime.value = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        selectedDateTime.value.hour,
        selectedDateTime.value.minute,
      );
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime.value),
    );

    if (pickedTime != null) {
      selectedDateTime.value = DateTime(
        selectedDateTime.value.year,
        selectedDateTime.value.month,
        selectedDateTime.value.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    }
  }

  void getInventories({Map<String, dynamic>? query}) async {
    try {
      isLoading.value = true;
      final response = await inventoryRepository.getInventories();
      final responseFilteredOut = await inventoryRepository
          .getInventories(query: {'inventoryType': 'Out'});
      final responseFilteredIn = await inventoryRepository
          .getInventories(query: {'inventoryType': 'In'});

      inventoryList.value = response;
      stockOutList.value = responseFilteredOut;
      stockInList.value = responseFilteredIn;
    } catch (e) {
      // TODO
      print('Failed to load inventory$e');
    } finally {
      isLoading.value = false;
    }
  }

  void getProducts() async {
    final response = await productRepository.getProducts();
    products.value = response;
  }

  void removeMedicine(InventoryItemModel item) {
    final items = inventory.value.items!;
    final index =
        items.indexWhere((element) => element.product!.id == item.product!.id);
    // print("index : $index");

    if (index >= 0) {
      items.removeAt(index);
      // print("Removed item: ${item.product!.name}");
    }

    inventory.refresh();
  }

  void reduceQuantity(InventoryItemModel item, int minValue) {
    final items = inventory.value.items!;
    final index =
        items.indexWhere((element) => element.product!.id == item.product!.id);
    // print("index : $index");

    if (index >= 0) {
      if (items[index].quantity! > minValue) {
        items[index].quantity = (items[index].quantity ?? 0) - 1;
        // print("Reduced quantity for ${item.product!.name}");
        calculateDiscrepancy(item);
      }
    }

    inventory.refresh();
  }


  void addMedicine(InventoryItemModel item) {
    final items = inventory.value.items!;
    final index =
        items.indexWhere((element) => element.product!.id == item.product!.id);
    // print("index : $index");

    if (index >= 0) {
      // Jika produk sudah ada, tambahkan quantity
      items[index].quantity = (items[index].quantity ?? 0) + 1;
      // print("Updated quantity for ${item.product!.name}");
      calculateDiscrepancy(item);
    } else {
      // Jika produk belum ada, tambahkan sebagai item baru
      items.add(item);

      // print("Added new item: ${item.product!.name}");
    }

    inventory.refresh();
  }

  void createStockIn() async {
    try {
      print("Create StockIn");
      final isCreated = await inventoryRepository
          .createInventory(inventory.value.stockinToJson());
      print("isCreated: $isCreated");

      if (isCreated) {
        Get.back(result: true);
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

  void createStockOut() async {
    try {
      print("Create StockOut");
      final isCreated = await inventoryRepository
          .createInventory(inventory.value.stockoutToJson());
      print("isCreated: $isCreated");

      if (isCreated) {
        Get.back(result: true);
        CustomSnackbar.showSnackbar(Get.context!,
            message: "Stock Out successfully created",
            title: 'Success!',
            contentType: ContentType.success);
      } else {
        CustomSnackbar.showSnackbar(Get.context!,
            message: "Failed to created stock out",
            title: "Failed!",
            contentType: ContentType.failure);
      }
    } catch (e) {
      print("Error Create StockOut");
    }
  }

  void clearForm() async {
    inventory.value = InventoryModel(
        items: [], inventoryDate: '', inventoryType: 'In', note: '');
    inventory.refresh();
  }

  void calculateDiscrepancy(InventoryItemModel item) {
    final items = inventory.value.items!;
    final index =
        items.indexWhere((element) => element.product!.id == item.product!.id);

    if (index >= 0) {
      final discrepancy = item.quantity! - items[index].product!.stockQuantity!;
      item.discrepancy ?? 0;
      items[index].discrepancy = discrepancy;
    }

    inventory.refresh();
  }
}
