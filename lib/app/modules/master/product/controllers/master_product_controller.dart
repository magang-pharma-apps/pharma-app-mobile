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

  ProductModel? productModel;

  void toggleEdit(bool value, int productId) {
    isEdit.value = value;
    if (value == true) {
      loadProduct(productId);
    }
  }

  var expiryDateController = TextEditingController();
  String? productCode =
      'DRUG-${Random().nextInt(max(1000000, 9999999)).toString()}';
  String? name;
  CategoryModel? selectedCategory;
  UnitModel? selectedUnit;
  String? selectedDrugClass;
  String? prescription;
  String? description;
  int? purchasePrice = 0.obs.value;
  int? sellingPrice;
  String? expiryDate;
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
        'expiryDate': expiryDate,
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
      await productRepository.updateProductById(id, {
        'productCode': productModel!.productCode,
        'name': productModel!.name,
        'description': productModel!.description,
        'purchasePrice': productModel!.purchasePrice,
        'sellingPrice': productModel!.sellingPrice,
        'expiryDate': productModel!.expiryDate,
        'stockQuantity': productModel!.stockQuantity,
        'categoryId': selectedCategory!.id,
        'unitId': selectedUnit!.id,
        'productImageUrl': productModel!.productImageUrl,
        'drugClass': selectedDrugClass,
      });
      Get.back(result: true);

      // Show success snackbar
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Success!',
        message: 'Product updated successfully',
        contentType: ContentType.success,
      );
    } catch (e) {
      // print('Error update product$e');
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
      productModel = product;
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
      productModel!.expiryDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      expiryDate = pickedDate.toIso8601String();
      productModel!.expiryDate = expiryDate;
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
