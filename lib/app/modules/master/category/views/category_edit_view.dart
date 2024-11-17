import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/modules/master/category/controllers/category_create_controller.dart';
import 'package:medpia_mobile/app/modules/master/category/controllers/category_list_controller.dart';

class CategoryEditView extends GetView<CategoryListController> {
  int? categoryId;
  CategoryEditView({super.key, this.categoryId});

  @override
  get controller => Get.put(CategoryListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            controller.updateCategory(categoryId!);
          },
          child: Text(
            'Update Category',
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
                    "Fill Category Detail",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  subtitle:
                      const Text("Fill in required fields to edit Category"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (value) {
                    controller.categoryModel!.value.name = value;
                  },
                  initialValue: controller.categoryModel!.value.name,
                  decoration: const InputDecoration(
                    labelText: 'Category Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue:
                      controller.categoryModel!.value.categoryImageUrl,
                  onChanged: (value) {
                    controller.categoryModel!.value.categoryImageUrl = value;
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
                  initialValue: controller.categoryModel!.value.description,
                  onChanged: (value) {
                    controller.categoryModel!.value.description = value;
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
