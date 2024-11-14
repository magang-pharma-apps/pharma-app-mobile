import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/modules/master/unit/controllers/unit_create_controller.dart';

class UnitFormView extends GetView<UnitCreateController> {
  const UnitFormView({super.key});

  @override
  get controller => Get.put(UnitCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            controller.createUnit();
          },
          child: Text(
            'Create Unit',
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
                "Fill Unit Detail",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              subtitle:
                  const Text("Fill in required fields to create a new unit"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                controller.name = value;
              },
              decoration: const InputDecoration(
                labelText: 'Unit Name',
              ),
            ),
            const SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}
