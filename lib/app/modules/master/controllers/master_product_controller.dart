import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

class MasterProductController extends GetxController {
  final productRepository = ProductRepository();

  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  var expiryDateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  void getProducts() async {
    try {
      isLoading.value = true;
      final response = await productRepository.getProducts();
      productList.value = response;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void createProduct() async {
    try {
      isLoading.value = true;
      final isCreated =
          await productRepository.createProduct({
            
          });

      if (isCreated) {
        CustomSnackbar.showSnackbar(Get.context!,
            title: "Created!",
            contentType: ContentType.success,
            message: "Product created successfully");
        Get.back(result: true);
        getProducts();
      } else {
        CustomSnackbar.showSnackbar(Get.context!,
            title: "Failed!",
            contentType: ContentType.failure,
            message: "Failed to create product");
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
