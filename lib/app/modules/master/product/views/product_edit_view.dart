import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/utils/rupiah_input_formatter.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/models/unit_model.dart';
import 'package:medpia_mobile/app/modules/master/product/controllers/master_product_controller.dart';
import 'package:medpia_mobile/app/repositories/category_repository.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';
import 'package:medpia_mobile/app/repositories/unit_repository.dart';

class ProductEditView extends GetView<MasterProductController> {
  final int productId;
  ProductEditView({super.key, required this.productId});

  @override
  get controller => Get.put(MasterProductController());
  // controller.loadProduct(productId);

  final productRepository = ProductRepository();
  final categoryRepository = CategoryRepository();
  final unitRepository = UnitRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            controller.updateProduct(productId);
          },
          child: Text(
            'Edit Product',
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.white),
          ),
        ),
      ],
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text('Product Form Edit',
            style: Theme.of(context).textTheme.labelLarge),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Fill Product Detail",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    subtitle: const Text(
                        "Fill in required fields to create a new product"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: controller.productModel!.value.productCode,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[100],
                      labelText: 'SKU (Product Code)',
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    initialValue: controller.productModel!.value.name,
                    onChanged: (value) {
                      controller.productModel!.value.name = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey[100],
                      labelText: 'Product Name',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: controller.formatToRupiah(
                        controller.productModel!.value.purchasePrice),
                    onChanged: (value) {
                      // Remove non-numeric characters before parsing to an integer
                      final numericValue =
                          value.replaceAll(RegExp(r'[^0-9]'), '');
                      controller.productModel!.value.purchasePrice =
                          int.tryParse(numericValue) ?? 0;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      RupiahInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                      labelText: 'Purchase Price',
                      hintText: 'Rp. 0',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: controller.formatToRupiah(
                        controller.productModel!.value.sellingPrice),
                    onChanged: (value) {
                      // Remove non-numeric characters before parsing to an integer
                      final numericValue =
                          value.replaceAll(RegExp(r'[^0-9]'), '');
                      controller.productModel!.value.sellingPrice =
                          int.tryParse(numericValue) ?? 0;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [RupiahInputFormatter()],
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                      labelText: 'Selling Price',
                      hintText:
                          controller.formatToRupiah(controller.sellingPrice),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    return TextFormField(
                      controller: TextEditingController(
                          text: controller.productModel!.value.expiryDate),
                      readOnly: true,
                      decoration: const InputDecoration(
                          labelText: 'Expiry Date',
                          suffixIcon: Icon(
                            HugeIcons.strokeRoundedCalendar02,
                            color: Colors.black,
                          )),
                      onTap: controller.pickExpireDate,
                      onChanged: (value) {
                        controller.expiryDate = value;
                        controller.productModel!.value.expiryDate = value;
                        controller.productModel!.refresh();
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<CategoryModel>(
                    decoration: const InputDecoration(
                      labelText: 'Select Category',
                    ),
                    value: controller.productModel!.value.category,
                    style: const TextStyle(color: Colors.black),
                    items: [
                      ...controller.categories.map((CategoryModel category) {
                        return DropdownMenuItem<CategoryModel>(
                          value: category,
                          child: Text(category.name!),
                        );
                      }),
                    ],
                    onChanged: (CategoryModel? value) {
                      final previousCategory =
                          controller.productModel!.value.category;
                      controller.productModel!.value.category = value;

                      print('Previous category: ${previousCategory?.name}');
                    },
                  ),

                  //
                  const SizedBox(height: 10),
                  Obx(() {
                    return DropdownButtonFormField<UnitModel>(
                      value: controller.productModel!.value.unit,
                      decoration: const InputDecoration(
                        labelText: 'Select Unit',
                      ),
                      // value: controller.productModel!.value.unit,
                      style: const TextStyle(color: Colors.black),
                      items: controller.units.map((UnitModel unit) {
                        return DropdownMenuItem<UnitModel>(
                          value: unit,
                          child: Text(unit.name!),
                        );
                      }).toList(),
                      onChanged: (UnitModel? value) {
                        controller.productModel!.value.unit = value;
                      },
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                      value: controller.productModel!.value.drugClass,
                      decoration: const InputDecoration(
                        labelText: 'Select Drug Class',
                      ),
                      // value: controller.productModel!.value.drugClass,
                      style: const TextStyle(color: Colors.black),
                      items: ['Obat Bebas', 'Obat Bebas Terbatas', 'Obat Keras']
                          .map((String drugClass) {
                        return DropdownMenuItem<String>(
                          value: drugClass,
                          child: Text(drugClass),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        controller.productModel!.value.drugClass = value;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue:
                        controller.productModel!.value.stockQuantity.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      controller.productModel!.value.stockQuantity =
                          int.parse(value);
                      // print('stockQuantity: ${controller.stockQuantity}');
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    decoration: InputDecoration(
                      fillColor: Colors.grey[100],
                      labelText: 'Stock Quantity',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue:
                        controller.productModel!.value.productImageUrl,
                    onChanged: (value) {
                      controller.productModel!.value.productImageUrl = value;
                      // print('productImageUrl: ${controller.productImageUrl}');
                    },
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                      labelText: 'Product Image Url',
                      hintText: 'Paste product image url here...',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: controller.productModel!.value.description,
                    onChanged: (value) {
                      controller.productModel!.value.description = value;
                    },
                    maxLines: 5,
                    decoration: const InputDecoration(
                        labelText: 'Description',
                        hintFadeDuration: Duration(seconds: 1),
                        alignLabelWithHint: true,
                        hintText: 'Write description here...',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                        constraints: BoxConstraints(maxHeight: 150)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ));
        }
      }),
    );
  }
}
