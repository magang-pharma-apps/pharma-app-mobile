import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/utils/email_input_formatter.dart';
import 'package:medpia_mobile/app/commons/utils/phone_input_formatter.dart';
import 'package:medpia_mobile/app/modules/master/doctor/controllers/doctor_list_controller.dart';

class DoctorEditView extends GetView<DoctorListController> {
  final int? doctorId;
  DoctorEditView({super.key, this.doctorId});

  @override
  get controller => Get.put(DoctorListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            controller.updateDoctor(doctorId!);
          },
          child: Text(
            'Update Doctor',
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
                    "Fill Doctor Detail",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  subtitle:
                      const Text("Fill in required fields to  edit Doctor"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: controller.doctorModel!.value.name,
                  onChanged: (value) {
                    controller.doctorModel!.value.name = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Doctor Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: controller.doctorModel!.value.specialization,
                  onChanged: (value) {
                    controller.doctorModel!.value.specialization = value;
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
                  initialValue: controller.doctorModel!.value.phoneNumber,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(
                        r'^[+\d\s-]*$')), // Allows only digits, spaces, +, and -
                    PhoneNumberTextInputFormatter(),
                    LengthLimitingTextInputFormatter(15)
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    } else if (!RegExp(r'^\+?[0-9\s-]{7,15}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    controller.doctorModel!.value.phoneNumber = value;
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
                  initialValue: controller.doctorModel!.value.email,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9@._-]')),
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
                    controller.doctorModel!.value.email = value;
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
          );
        }
      }),
    );
  }
}
