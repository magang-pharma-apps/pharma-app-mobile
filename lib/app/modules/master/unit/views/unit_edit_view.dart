import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/modules/master/unit/controllers/unit_create_controller.dart';
import 'package:medpia_mobile/app/modules/master/unit/controllers/unit_list_controller.dart';

class UnitEditView extends GetView<UnitListController> {
  final int unitId;
  const UnitEditView({super.key, required this.unitId});

  @override
  get controller => Get.put(UnitListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            controller.updateUnit(unitId);
          },
          child: Text(
            'Update Unit',
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
        title: Text('Unit Form', style: Theme.of(context).textTheme.labelLarge),
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
                    "Fill Unit Detail",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  subtitle:
                      const Text("Fill in required fields to edit a new unit"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: controller.unitModel!.value.name,
                  onChanged: (value) {
                    controller.unitModel!.value.name = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Unit Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: controller.unitModel!.value.description,
                  onChanged: (value) {
                    controller.unitModel!.value.description = value;
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
              ],
            ),
          );
        }
      }),
    );
  }
}
