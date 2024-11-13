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

  RxBool isLoadingUnits = false.obs;
  RxBool isLoadingCategories = false.obs;
  RxBool isLoadingProducts = false.obs;

  var expiryDateController = TextEditingController();
  String? productCode =
      'DRUG-${Random().nextInt(max(1000000, 9999999)).toString()}';
  String? name;
  CategoryModel? selectedCategory;
  UnitModel? selectedUnit;
  String? selectedDrugClass;
  String? prescription;
  String? description;
  int? purchasePrice;
  int? sellingPrice;
  String? expiryDate;
  int? stockQuantity;
  String? productImageUrl;

  @override
  void onInit() {
    super.onInit();
    getProducts();
    getUnits();
    getCategories();
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

  void getUnits() async{
    try{
      isLoadingUnits.value = true;
      final response = await unitRepository.getUnits();
      units.value = response;

    }catch(e){
      throw Exception('Failed to load units: $e');
    } finally {
      isLoadingUnits.value = false;
    }
  }

  void getCategories() async{
    try{
      isLoadingCategories.value = true;
      final response = await categoryRepository.getCategories();
      categories.value = response;

    }catch(e){
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
        'prescriptions': prescription,
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

      // Show success snackbar
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Success!',
        message: 'Product created successfully',
        contentType: ContentType.success,
      );
    } catch (e) {
      print('Error create product$e');
      // Show failure snackbar if there's an error
      CustomSnackbar.showSnackbar(
        Get.context!,
        title: 'Failed!',
        message: 'Failed to create product',
        contentType: ContentType.failure,
      );
    }
  }

  void pickExpireDate() async {
    DateTime? pickedDate = await showDatePicker(context: Get.context!, firstDate: DateTime.now(), 
    lastDate: DateTime(2101), initialDate: DateTime.now());

    if (pickedDate != null) {
      expiryDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      expiryDate = pickedDate.toIso8601String();
    }
  }
}
