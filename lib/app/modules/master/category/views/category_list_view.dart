import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/modules/master/category/controllers/category_list_controller.dart';
import 'package:medpia_mobile/app/modules/master/category/views/category_edit_view.dart';
import 'package:medpia_mobile/app/modules/master/category/views/category_form_view.dart';
import 'package:medpia_mobile/app/repositories/category_repository.dart';

class CategoryListView extends GetView<CategoryListController> {
  CategoryListView({super.key});

  @override
  get controller => Get.put(CategoryListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        InkWell(
          onTap: () {
            Get.to(() => const CategoryFormView())?.then((result) {
              if (result == true) {
                controller.getCategories();
              }
            });
          },
          child: Center(
            child: Column(
              children: [
                Icon(
                  HugeIcons.strokeRoundedFileAdd,
                  color: Colors.grey.shade700,
                ),
                Text('Create New Category',
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
        )
      ],
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Master Category',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  visualDensity: VisualDensity.compact,
                  contentPadding:
                      const EdgeInsets.only(bottom: 5, left: 15, right: 15),
                  title: Text(category.name!),
                  subtitle: Text(
                    '${category.description}',
                    maxLines: 2,
                  ),
                  onTap: () {
                    Get.to(CategoryEditView());
                  },
                  onLongPress: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            title: Text(
                              category.name!,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            actions: [
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Get.to(CategoryEditView());
                                },
                                child: Text('Edit'),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () {},
                                child: Text('Delete'),
                              ),
                            ],
                          );
                        });
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
