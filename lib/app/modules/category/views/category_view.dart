import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/category_widget.dart';
import 'package:medpia_mobile/app/modules/category/controllers/category_controller.dart';
import 'package:medpia_mobile/app/modules/product/views/product_view.dart';

class CategoryView extends GetView<CategoryController> {
  CategoryView({
    super.key,
  });

  @override
  get controller => Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text('All Categories',
            style: Theme.of(context).textTheme.labelLarge),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final category = controller.categoryList[index];
                    // print(category);
                    return CategoryWidget(
                      onTap: () {
                        
                        Get.to(ProductView(), arguments: category.id);
                      },
                      categoryModel: category,
                      productCount:
                          '(${controller.getProductsByCategory(category.id)})',
                    );
                  },
                  itemCount: controller.categoryList.length,
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
