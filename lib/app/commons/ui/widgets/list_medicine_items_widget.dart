import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/search_widget.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/modules/prescription/controllers/list_medicine_items_controller.dart';

class ListMedicineItemsWidget extends GetView<ListMedicineItemsController> {
  const ListMedicineItemsWidget({
    super.key,
  });

  @override
  // TODO: implement controller
  get controller => Get.put(ListMedicineItemsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            heightFactor: 2,
            child: Text("List Medicines", style: Get.textTheme.labelMedium),
          ),
          SearchWidget(),
          SizedBox(height: 5),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return ListTile(
                      dense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      title: Text(product.name!),
                      trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            controller.addMedicine(CartItemModel(
                                product: product, quantity: 1, note: ""));
                            Get.back();
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(fontSize: 11),
                          )));
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
