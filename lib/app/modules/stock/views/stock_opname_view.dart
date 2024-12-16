import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/enums/last_opname_status.dart';
import 'package:medpia_mobile/app/commons/utils/scan_qr.dart';
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
                  Get.to(() => StockOpnameForm())?.then((result) {
                    if (result == true) {
                      controller.getProducts();
                      controller.isShow.value = false;
                      controller.inventory.value.items!.clear();
                      controller.inventory.refresh();
                    }
                  });
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
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Stock Opname",
              style: Theme.of(context).textTheme.labelSmall!,
            ),
            SizedBox(
              height: 5,
            ),
            SearchBar(
              hintText: 'Search Product SKU',
              hintStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 12, color: Colors.grey)),
              onChanged: (value) {
                controller.search.value = value;
                controller.getProducts();
              },
              elevation: WidgetStatePropertyAll(0),
              constraints: BoxConstraints(maxHeight: 30),
              leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              trailing: [
                IconButton(
                    onPressed: closeSearch,
                    icon: Icon(Icons.medication_outlined)),
                IconButton(
                  onPressed: () {
                    Get.to(() => ScanQr(setResult: setResult));
                  },
                  icon: const Icon(Icons.qr_code_scanner_sharp),
                )
              ],
            ),
          ],
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
                                      physicalStock: product.stockQuantity,
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
              isThreeLine: true,
              dense: true,
              leading: CircleAvatar(
                radius: 20,
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
              contentPadding: EdgeInsets.only(left: 10),
              title: Container(
                padding: EdgeInsets.all(3),
                margin: EdgeInsets.only(bottom: 3),
                decoration: controller.getOpnameStatus(product).boxDecoration,
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      controller.getOpnameStatus(product).text,
                      style: Get.textTheme.labelSmall!.copyWith(
                          fontSize: 10,
                          color: controller
                              .getOpnameStatus(product)
                              .textStyle
                              .color),
                    ),
                    product.lastOpname?.opnameDate?.isNotEmpty == true
                        ? Text(
                            'Last Opt. ${DateFormat('dd/MM/yy').format(DateTime.parse(product.lastOpname!.opnameDate!))}',
                            style: Get.textTheme.bodySmall!.copyWith(
                                color: controller
                                    .getOpnameStatus(product)
                                    .textStyle
                                    .color),
                          )
                        : SizedBox.shrink(),
                    product.lastOpname?.opnameDate?.isNotEmpty == true
                        ? Text(
                            'Discrepancy: ${product.discrepancy}',
                            style: Get.textTheme.bodySmall!.copyWith(
                                color: controller
                                    .getOpnameStatus(product)
                                    .textStyle
                                    .color),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    style: Get.textTheme.labelSmall!,
                  ),
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
                                controller.inventory.value.items!.add(
                                    productOpname.copyWith(
                                        physicalStock: product.stockQuantity));
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
              onLongPress: () {
                controller.isShow.value = true;
                controller.inventory.value.items!.add(InventoryItemModel(
                    product: product,
                    physicalStock: product.stockQuantity,
                    quantity: product.stockQuantity,
                    note: ""));
                controller.inventory.refresh();
              },
            );
          },
        );
      }),
    );
  }

  void setResult(String result) {
    print('result barcode scan: $result');
    controller.search.value = result;
    controller.getProducts();

    // Future.delayed(
    //   Duration(milliseconds: 500),
    //   () {
    //     Get.to(const StockOpnameView(), arguments: result);
    //   },
    // );
  }

  void closeSearch() {
    controller.search.value = '';
    controller.getProducts();
  }
}
