import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_confirm_modal.dart';
import 'package:medpia_mobile/app/modules/master/product/controllers/master_product_controller.dart';
import 'package:medpia_mobile/app/modules/master/product/views/product_edit_view.dart';
import 'package:medpia_mobile/app/modules/master/product/views/product_form_view.dart';

class ProductListView extends GetView<MasterProductController> {
  const ProductListView({
    super.key,
  });

  @override
  get controller => Get.put(MasterProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        InkWell(
          onTap: () {
            Get.to(() => ProductFormView())?.then((result) {
              if (result == true) {
                controller.getProducts();
              }
            });
          },
          child: Center(
            child: Column(
              children: [
                Icon(
                  HugeIcons.strokeRoundedMedicine01,
                  color: Colors.grey.shade700,
                ),
                Text('Create New Medicine',
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
        )
      ],
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Medicine List',
            style: Theme.of(context).textTheme.labelLarge),
      ),
      body: Obx(() {
        if (controller.isLoadingProducts.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              final product = controller.productList[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                ),
                child: ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text(product.name!,
                      style: Theme.of(context).textTheme.labelSmall),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category!.name!,
                      ),
                      Text(
                          'Expired on ${DateFormat('dd/MM/yy').format(DateTime.parse(product.expiryDate!))}'),
                    ],
                  ),
                  trailing: Text(
                    '${product.stockQuantity} ${product.unit!.name}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () {
                    controller.toggleEdit(true, product.id!);
                    // print('Product ID: ${product.id}');
                    Get.to(ProductEditView(productId: product.id!));
                  },
                  onLongPress: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            title: Text(
                              product.name!,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            actions: [
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  controller.toggleEdit(true, product.id!);
                                  Get.to(
                                      ProductEditView(productId: product.id!));
                                },
                                child: Text('Edit'),
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

