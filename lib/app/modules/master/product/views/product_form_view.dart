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

class ProductFormView extends GetView<MasterProductController> {
  ProductFormView({super.key});

  @override
  get controller => Get.put(MasterProductController());

  final productRepository = ProductRepository();
  final categoryRepository = CategoryRepository();
  final unitRepository = UnitRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            controller.createProduct();
          },
          child: Text(
            'Add Product',
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.white),
          ),
        ),
      ],
      appBar: AppBar(
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
        title:
            Text('Product Form', style: Theme.of(context).textTheme.labelLarge),
      ),
      body: Container(
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
                initialValue: controller.productCode,
                decoration: const InputDecoration(
                  labelText: 'Product Code',
                ),
                readOnly: true,
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  controller.name = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: controller.onPurchasePriceChanged,
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
                  hintText: controller.formatToRupiah(controller.purchasePrice),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: controller.onSellingPriceChanged,
                keyboardType: TextInputType.number,
                inputFormatters: [RupiahInputFormatter()],
                decoration: InputDecoration(
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                  labelText: 'Selling Price',
                  hintText: controller.formatToRupiah(controller.sellingPrice),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                  readOnly: true,
                  controller: controller.expiryDateController,
                  decoration: const InputDecoration(
                      labelText: 'Expiry Date',
                      suffixIcon: Icon(
                        HugeIcons.strokeRoundedCalendar02,
                        color: Colors.black,
                      )),
                  onTap: controller.pickExpireDate),
              const SizedBox(height: 10),
              DropdownButtonFormField<CategoryModel>(
                decoration: const InputDecoration(
                  labelText: 'Select Category',
                ),
                value: controller.categories.isNotEmpty
                    ? controller.categories.first
                    : null,
                style: const TextStyle(color: Colors.black),
                items: controller.categories.map((CategoryModel category) {
                  // print('customer: $customer');
                  return DropdownMenuItem<CategoryModel>(
                    value: category,
                    child: Text(category.name!),
                  );
                }).toList(),
                onChanged: (CategoryModel? value) {
                  controller.selectedCategory = value;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<UnitModel>(
                decoration: const InputDecoration(
                  labelText: 'Select Unit',
                ),
                value:
                    controller.units.isNotEmpty ? controller.units.first : null,
                style: const TextStyle(color: Colors.black),
                items: controller.units.map((UnitModel unit) {
                  return DropdownMenuItem<UnitModel>(
                    value: unit,
                    child: Text(unit.name!),
                  );
                }).toList(),
                onChanged: (UnitModel? value) {
                  controller.selectedUnit = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Drug Class',
                  ),
                  value: controller.selectedDrugClass,
                  style: const TextStyle(color: Colors.black),
                  items: ['Obat Bebas', 'Obat Bebas Terbatas', 'Obat Keras']
                      .map((String drugClass) {
                    return DropdownMenuItem<String>(
                      value: drugClass,
                      child: Text(drugClass),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    controller.selectedDrugClass = value;
                  }),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.stockQuantity = int.parse(value);
                  // print('stockQuantity: ${controller.stockQuantity}');
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                decoration: const InputDecoration(
                  labelText: 'Stock Quantity',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  controller.productImageUrl = value;
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
                onChanged: (value) {
                  controller.description = value;
                  
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
          )),
    );
  }
}
