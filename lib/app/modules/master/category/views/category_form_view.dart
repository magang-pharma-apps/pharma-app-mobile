
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/modules/master/category/controllers/category_create_controller.dart';

class CategoryFormView extends GetView<CategoryCreateController> {
  const CategoryFormView({super.key});

  @override
  get controller => Get.put(CategoryCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            controller.createCategory();
          },
          child: Text(
            'Create Category',
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
        title: Text('Category Form',
            style: Theme.of(context).textTheme.labelLarge),
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
                "Fill Category Detail",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              subtitle: const Text(
                  "Fill in required fields to create a new Category"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                controller.name = value;
              },
              decoration: const InputDecoration(
                labelText: 'Category Name',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                controller.categoryImageUrl = value;
              },
              decoration: InputDecoration(
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey),
                labelText: 'Category Image Url',
                hintText: 'Paste category image url here...',
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
