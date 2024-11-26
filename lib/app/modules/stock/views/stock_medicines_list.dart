import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/search_widget.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/inventory_item_model.dart';
import 'package:medpia_mobile/app/modules/prescription/controllers/list_medicine_items_controller.dart';
import 'package:medpia_mobile/app/modules/stock/controllers/stock_controller.dart';
import 'package:medpia_mobile/app/modules/stock/controllers/stock_medicine_list_controller.dart';

class StockMedicinesList extends GetView<StockMedicineListController> {
  const StockMedicinesList({
    super.key,
  });

  @override
  // TODO: implement controller
  get controller => Get.put(StockMedicineListController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.all(0),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
            title: Text("Search Medicines", style: Get.textTheme.labelMedium),
            subtitle: Obx(() {
              return Text(
                controller.products.length.toString() + " products",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey),
              );
            }),
          ),
          Divider(
            thickness: 0.5,
            height: 0.5,
          ),
          SizedBox(height: 5),
          SearchWidget(),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("List Medicines", style: Get.textTheme.labelSmall),
              IconButton(
                  onPressed: () {
                    controller.getProducts();
                  },
                  icon: Icon(Icons.refresh, size: 20))
            ],
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return ListTile(
                      onTap: () => {
                            controller.addMedicine(InventoryItemModel(
                                product: product, quantity: 1, note: "")),
                            Get.back(),

                            // controller.addMedicine(InventoryItemModel(
                            //     product: product, quantity: 1, note: "")),
                            // print("product exisst : ${product.id}")
                          },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.tealAccent.shade700,
                        child: Icon(
                          HugeIcons.strokeRoundedMedicineBottle01,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      dense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      title: Text(product.name!),
                      subtitle: Text(
                        product.category!.name!,
                        style: Get.textTheme.bodySmall!
                            .copyWith(color: Colors.grey.shade600),
                      ));
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
