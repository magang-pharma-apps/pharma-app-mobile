import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/models/prescription_model.dart';
import 'package:medpia_mobile/app/models/unit_model.dart';
import 'package:medpia_mobile/app/modules/prescription/views/redemption_form.dart';
import 'package:medpia_mobile/app/repositories/category_repository.dart';
import 'package:medpia_mobile/app/repositories/prescription_repository.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';
import 'package:medpia_mobile/app/repositories/unit_repository.dart';

class MasterProductForm extends StatefulWidget {
  VoidCallback? onPrescriptionAdded;
  MasterProductForm({super.key, this.onPrescriptionAdded});

  @override
  State<MasterProductForm> createState() => _MasterProductFormState();
}

class _MasterProductFormState extends State<MasterProductForm> {
  final productRepository = ProductRepository();
  final categoryRepository = CategoryRepository();
  final unitRepository = UnitRepository();
  TextEditingController expiryDateController = TextEditingController();

  bool isRedeem = false;

  String? productCode = 'DRUG${Random().nextInt(max(1000, 9999)).toString()}';
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

  List<CategoryModel> categories = [];
  List<UnitModel> units = [];

  @override
  void initState() {
    super.initState();
    getCategories();
    getUnits();
    if (expiryDateController.text.isNotEmpty) {
      expiryDate = DateFormat('dd/MM/yyyy')
          .parse(expiryDateController.text)
          .toIso8601String();
    }
  }

  @override
  void dispose() {
    expiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            createProduct();
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
                initialValue: productCode,
                decoration: const InputDecoration(
                  labelText: 'Product Code',
                ),
                readOnly: true,
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  name = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  purchasePrice = int.parse(value);
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny(RegExp(r'^0')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Purchase Price',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  sellingPrice = int.parse(value);
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny(RegExp(r'^0')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Selling Price',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                readOnly: true,
                controller: expiryDateController,
                decoration: const InputDecoration(
                    labelText: 'Expiry Date',
                    suffixIcon: Icon(
                      HugeIcons.strokeRoundedCalendar01,
                      color: Colors.black,
                    )),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      expiryDateController.text =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                      expiryDate = pickedDate.toIso8601String();
                      print(expiryDate);
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<CategoryModel>(
                decoration: const InputDecoration(
                  labelText: 'Select Category',
                ),
                value: selectedCategory,
                style: const TextStyle(color: Colors.black),
                items: categories.map((CategoryModel customer) {
                  // print('customer: $customer');
                  return DropdownMenuItem<CategoryModel>(
                    value: customer,
                    child: Text(customer.name!),
                  );
                }).toList(),
                onChanged: (CategoryModel? value) {
                  selectedCategory = value;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<UnitModel>(
                decoration: const InputDecoration(
                  labelText: 'Select Unit',
                ),
                value: selectedUnit,
                style: const TextStyle(color: Colors.black),
                items: units.map((UnitModel doctor) {
                  return DropdownMenuItem<UnitModel>(
                    value: doctor,
                    child: Text(doctor.name!),
                  );
                }).toList(),
                onChanged: (UnitModel? value) {
                  selectedUnit = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Drug Class',
                  ),
                  value: selectedDrugClass,
                  style: const TextStyle(color: Colors.black),
                  items: ['Obat Bebas', 'Obat Bebas Terbatas', 'Obat Keras']
                      .map((String drugClass) {
                    return DropdownMenuItem<String>(
                      value: drugClass,
                      child: Text(drugClass),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    selectedDrugClass = value;
                  }),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  stockQuantity = int.parse(value);
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
                  productImageUrl = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Image Url',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  description = value;
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

  void getCategories() async {
    final response = await categoryRepository.getCategories();
    setState(() {
      categories = response;
    });
  }

  void getUnits() async {
    final response = await unitRepository.getUnits();
    setState(() {
      units = response;
    });
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
      Navigator.pop(context, true);

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
}
