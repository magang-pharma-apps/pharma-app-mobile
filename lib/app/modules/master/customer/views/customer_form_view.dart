import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/utils/email_input_formatter.dart';
import 'package:medpia_mobile/app/commons/utils/phone_input_formatter.dart';
import 'package:medpia_mobile/app/modules/master/category/controllers/category_create_controller.dart';
import 'package:medpia_mobile/app/modules/master/customer/controllers/customer_create_controller.dart';
import 'package:medpia_mobile/app/modules/master/doctor/controllers/doctor_create_controller.dart';

class CustomerFormView extends GetView<CustomerCreateController> {
  const CustomerFormView({super.key});

  @override
  get controller => Get.put(CustomerCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            controller.createCustomer();
          },
          child: Text(
            'Add Patient Data',
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
            Text('Patient Form', style: Theme.of(context).textTheme.labelLarge),
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
                "Fill Patient Detail",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              subtitle: const Text(
                  "Fill in required fields to create a new Patient data"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                controller.name = value;
              },
              decoration: const InputDecoration(
                labelText: 'Patient Name',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(3)
              ],
              onChanged: (value) {
                controller.age = int.parse(value);
                ;
              },
              decoration: InputDecoration(
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey),
                labelText: 'Patient Age',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                controller.address = value;
              },
              maxLines: 5,
              decoration: const InputDecoration(
                  labelText: 'Address',
                  hintFadeDuration: Duration(seconds: 1),
                  alignLabelWithHint: true,
                  hintText: 'Jl. Kebon Jeruk No. 12, Jakarta Barat',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                  constraints: BoxConstraints(maxHeight: 150)),
            ),
          ],
        ),
      ),
    );
  }
}
