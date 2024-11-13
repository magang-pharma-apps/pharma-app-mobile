import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/modules/master/controllers/master_product_controller.dart';
import 'package:medpia_mobile/app/modules/master/views/master_product_edit.dart';
import 'package:medpia_mobile/app/modules/master/views/master_product_form.dart';

class MasterProductList extends GetView<MasterProductController> {
  const MasterProductList({super.key});

  @override
  get controller => Get.put(MasterProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        InkWell(
          onTap: () {
            Get.to(() => MasterProductForm())?.then((result) {
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
                  subtitle: Text(
                      'Expired on ${DateFormat('yyyy-MM-dd').format(DateTime.parse(product.expiryDate!))}'),
                  trailing: Text(
                    '${product.stockQuantity} ${product.unit!.name}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () {
                    Get.to(const MasterProductEdit());
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
                                  Get.to(const MasterProductEdit());
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
