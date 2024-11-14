import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/utils/email_input_formatter.dart';
import 'package:medpia_mobile/app/commons/utils/phone_input_formatter.dart';
import 'package:medpia_mobile/app/modules/master/doctor/controllers/doctor_create_controller.dart';

class DoctorFormView extends GetView<DoctorCreateController> {
  const DoctorFormView({super.key});

  @override
  get controller => Get.put(DoctorCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            controller.createDoctor();
          },
          child: Text(
            'Create Doctor',
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
            Text('Doctor Form', style: Theme.of(context).textTheme.labelLarge),
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
                "Fill Doctor Detail",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              subtitle: const Text(
                  "Fill in required fields to create a new Doctor"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                controller.name = value;
              },
              decoration: const InputDecoration(
                labelText: 'Doctor Name',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                controller.specialization = value;
              },
              decoration: InputDecoration(
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey),
                labelText: 'Specialization',
                hintText: 'Enter specialization here...',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(
                    r'^[+\d\s-]*$')), // Allows only digits, spaces, +, and -
                PhoneNumberTextInputFormatter(),
                LengthLimitingTextInputFormatter(15)
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                } else if (!RegExp(r'^\+?[0-9\s-]{7,15}$').hasMatch(value)) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                controller.phoneNumber = value;
              },
              decoration: InputDecoration(
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey),
                labelText: 'Phone Number',
                hintText: ' +62xxxxxxxxxx',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
                EmailTextInputFormatter()
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email is required';
                } else if (!RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              onChanged: (value) {
                controller.email = value;
              },
              decoration: InputDecoration(
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey),
                labelText: 'Email',
                hintText: 'jhon@mail.com',
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
