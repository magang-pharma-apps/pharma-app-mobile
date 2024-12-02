import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/models/unit_model.dart';
import 'package:medpia_mobile/app/modules/master/product/views/product_list_view.dart';
import 'package:medpia_mobile/app/repositories/category_repository.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';
import 'package:medpia_mobile/app/repositories/unit_repository.dart';

class MasterProductController extends GetxController {
  final productRepository = ProductRepository();
  final unitRepository = UnitRepository();
  final categoryRepository = CategoryRepository();

  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<UnitModel> units = <UnitModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingUnits = false.obs;
  RxBool isLoadingCategories = false.obs;
  RxBool isLoadingProducts = false.obs;
  RxBool isEdit = false.obs;

  Rx<ProductModel>? productModel = ProductModel().obs;

  void toggleEdit(bool value, int productId) {
    isEdit.value = value;
    if (value == true) {
      loadProduct(productId);
    }
  }

  var expiryDateController = TextEditingController();
  String? productCode =
      '${Random().nextInt(max(1000, 9999)).toString()}';
  String? name;
  CategoryModel? selectedCategory;
  UnitModel? selectedUnit;
  String? selectedDrugClass;
  String? prescription;
  String? description;
  int? purchasePrice = 0.obs.value;
  int? sellingPrice;
  String? expiryDate = ''.obs.value;
  int? stockQuantity;
  String? productImageUrl;

  String? formatToRupiah(int? amount) {
    if (amount == null) return 'Rp 0';
    final formatter = NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  void onInit() {
    super.onInit();
    getProducts();
    getUnits();
    getCategories();

    // ignore: unrelated_type_equality_checks
  }

  void getProducts() async {
    try {
      isLoadingProducts.value = true;
      final response = await productRepository.getProducts();
      productList.value = response;
    } catch (e) {
      throw Exception('Failed to load products: $e');
    } finally {
      isLoadingProducts.value = false;
    }
  }

  void getProductById(int id) async {
    try {
      final response = await productRepository.getProductById(id);
      print(response);
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

  void getUnits() async {
    try {
      isLoadingUnits.value = true;
      final response = await unitRepository.getUnits();
      units.value = response;
    } catch (e) {
      throw Exception('Failed to load units: $e');
    } finally {
      isLoadingUnits.value = false;
    }
  }

  void getCategories() async {
    try {
      isLoadingCategories.value = true;
      final response = await categoryRepository.getCategories();
      categories.value = response;
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    } finally {
      isLoadingCategories.value = false;
    }
  }

  void createProduct() async {
    try {
      await productRepository.createProduct({
        'productCode': productCode,
        'name': name,
        'description': description,
        'purchasePrice': purchasePrice,
        'sellingPrice': sellingPrice,
        'expiryDate': expiryDate != null
            ? DateFormat('yyyy-MM-nddTHH:mm:ss.SSSZ').format(
                DateFormat('dd-MM-yyyy').parse(expiryDate!),
              )
            : null,
        'stockQuantity': stockQuantity,
        'categoryId': selectedCategory!.id,
        'unitId': selectedUnit!.id,
        'productImageUrl': productImageUrl,
        'drugClass': selectedDrugClass,
      });
      Get.back(result: true);

      // Show success snackbaraa
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Success!',
        message: 'Product created successfully',
        contentType: ContentType.success,
      );
    } catch (e) {
      // print('Error create product$e');
      // Show failure snackbar if there's an error
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Failed!',
        message: 'Failed to create product',
        contentType: ContentType.failure,
      );
    }
  }

  void deleteProduct(int id) async {
    try {
      await productRepository.deleteProductById(id);

      // tambahin pop up dialog konfirmasi delete
      int count = 0;
      Get.until((route) {
        count++;
        return count == 2; // Stop after going back two pages
      });
      getProducts();

      // Show success snackbar
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Success!',
        message: 'Product deleted successfully',
        contentType: ContentType.success,
      );
    } catch (e) {
      // print('Error delete product$e');
      // Show failure snackbar if there's an error
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Failed!',
        message: 'Failed to delete product',
        contentType: ContentType.failure,
      );
    }
  }

  void updateProduct(int id) async {
    try {
      print('productModel!.value.toJson(): ${productModel!.value.toJson()}');
      await productRepository.updateProductById(
          id, productModel!.value.toJson());
      Get.back(result: true);
      getProducts();

      // Show success snackbar
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Success!',
        message: 'Product updated successfully',
        contentType: ContentType.success,
      );
    } catch (e) {
      print('Error update product$e');
      // Show failure snackbar if there's an error
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Failed!',
        message: 'Failed to update product',
        contentType: ContentType.failure,
      );
    }
  }

  void loadProduct(int productId) async {
    isLoading.value = true;

    try {
      final product = await productRepository.getProductById(productId);
      productModel!.value = product;
      productModel!.value.expiryDate = DateFormat('dd-MM-yyyy')
          .format(DateTime.parse(productModel!.value.expiryDate!));
      productModel!.value.category = null;
      productModel!.value.unit = null;
    } catch (e) {
      throw Exception('Failed to load product: $e');
      // TODO
    } finally {
      isLoading.value = false;
    }
  }

  void pickExpireDate() async {
    DateTime? pickedDate = await showDatePicker(
        onDatePickerModeChange: (value) {
          print('onDatePickerModeChange: $value');
        },
        context: Get.context!,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
        initialDate: DateTime.now());

    if (pickedDate != null) {
      productModel!.value.expiryDate =
          DateFormat('dd-MM-yyyy').format(pickedDate);
      expiryDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      // expiryDate = pickedDate.toIso8601String();
      // productModel!.value.expiryDate = expiryDate;
      expiryDateController.text = expiryDate!;
      productModel!.refresh();

      print('expiryDate from productModel: ${productModel!.value.expiryDate}');
      print('expiryDate: $expiryDate');
    }
  }

  void onPurchasePriceChanged(String value) {
    if (value.isEmpty) {
      purchasePrice = 0;
    } else {
      value = value.replaceAll(RegExp(r'[^0-9]'), '');
      purchasePrice = int.parse(value);
      // print('purchasePrice: $purchasePrice');
    }
  }

  void onSellingPriceChanged(String value) {
    if (value.isEmpty) {
      sellingPrice = 0;
    } else {
      sellingPrice = int.parse(value);
      // print('sellingPrice: $sellingPrice');
    }
  }
}
