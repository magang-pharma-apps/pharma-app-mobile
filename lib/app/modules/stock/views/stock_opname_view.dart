import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/models/inventory_item_model.dart';
import 'package:medpia_mobile/app/modules/stock/controllers/stock_controller.dart';
import 'package:medpia_mobile/app/modules/stock/views/stock_opname_form.dart';

class StockOpnameView extends GetView<StockController> {
  const StockOpnameView({super.key});

  @override
  get controller => Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Obx(() {
          return Visibility(
            visible: controller.inventory.value.items!.isNotEmpty,
            child: ElevatedButton(
                onPressed: () {
                  Get.to(StockOpnameForm());
                },
                style: ElevatedButton.styleFrom(fixedSize: Size(Get.width, 20)),
                child: Text(
                  "Opname Now",
                  style: TextStyle(fontSize: 14),
                )),
          );
        }),
      ],
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: false,
        backgroundColor: Colors.white,
        title: Text(
          "Stock Opname",
          style: Theme.of(context).textTheme.labelMedium!,
        ),
        actions: [
          Obx(() {
            return controller.isShow.value
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {
                        controller.isShow.value = false;
                        controller.inventory.value.items!.clear();
                        controller.inventory.refresh();
                      },
                      child: Row(
                        children: [
                          Text("Cancel",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.teal)),
                          Checkbox(
                            activeColor: Colors.teal,
                            value: controller.inventory.value.items!.length ==
                                controller.products.length,
                            onChanged: (value) {
                              if (value == true) {
                                controller.inventory.value.items!.clear();
                                controller.inventory.value.items!
                                    .addAll(controller.products.map((product) {
                                  return InventoryItemModel(
                                      product: product,
                                      quantity: product.stockQuantity,
                                      note: "");
                                }).toList());
                              } else {
                                controller.inventory.value.items!.clear();
                              }
                              controller.inventory.refresh();
                            },
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
      

            return ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.tealAccent.shade700,
                child: const Icon(
                  HugeIcons.strokeRoundedMedicineBottle01,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              shape: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              title: Text(
                product.name!,
                style: Get.textTheme.labelSmall!,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SKU: ${product.productCode}',
                    style: Get.textTheme.bodyMedium!,
                  ),
                  Text(
                    'Stock: ${product.stockQuantity} ${product.unit!.name}',
                    style: Get.textTheme.bodyMedium!
                        .copyWith(color: product.stockColorInfo),
                  ),
                  Text(
                    'Exp Date: ${DateFormat('dd/MM/yy').format(DateTime.parse(product.expiryDate!))}',
                    style: Get.textTheme.bodyMedium!
                        .copyWith(color: product.expiryCategory),
                  ),
                ],
              ),
              trailing: Obx(() {
                final productOpname = InventoryItemModel(
                    product: product,
                    quantity: product.stockQuantity,
                    note: "");
                return controller.isShow.value
                    ? Obx(() {
                        return Checkbox(
                            activeColor: Colors.teal,
                            value: controller.inventory.value.items!.any(
                                (element) => element.product!.id == product.id),
                            onChanged: (value) {
                              if (value == true) {
                                controller.inventory.value.items!
                                    .add(productOpname);
                                controller.inventory.refresh();

                                // print(controller.inventory.value.items);
                              } else {
                                controller.inventory.value.items!.removeWhere(
                                    (element) =>
                                        element.product!.id == product.id);
                                controller.inventory.refresh();
                              }
                            });
                      })
                    : SizedBox.shrink();
              }),
              onLongPress: () => controller.isShow.value = true,
            );
          },
        );
      }),
    );
  }
}
