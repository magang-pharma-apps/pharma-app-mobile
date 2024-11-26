import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/list_medicine_items_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/note_item_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/note_prescription.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/cart_model.dart';
import 'package:medpia_mobile/app/modules/prescription/controllers/redemption_controller.dart';
import 'package:medpia_mobile/app/modules/stock/controllers/stock_controller.dart';
import 'package:medpia_mobile/app/modules/stock/views/stock_medicines_list.dart';

class StockInForm extends GetView<StockController> {
  const StockInForm({super.key});

  @override
  get controller => Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(Get.width, 50),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
              onPressed: () {},
              child: Text('Save')),
        ],
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Stock In Form',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          height: Get.height * 0.8,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: TextEditingController()
                    ..text = controller.formattedDate,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'Select Date',
                      labelText: 'Date',
                      suffixIcon: Icon(
                        HugeIcons.strokeRoundedCalendar02,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Colors.grey.shade600, fontSize: 12),
                      labelText: 'Note',
                      hintText: 'Write a note',
                      suffixIcon: Icon(
                        HugeIcons.strokeRoundedStickyNote02,
                        size: 20,
                        color: Colors.black,
                      )),
                  // onChanged: (value) {
                  //   controller.supplierName = value;
                  // },
                ),
              ),
              Obx(() {
                return Visibility(
                    visible: controller.inventory.value.items!.isEmpty,
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                              labelText: 'Product',
                              hintText: 'Choose Product',
                              suffixIcon: Icon(
                                HugeIcons.strokeRoundedPackageSearch,
                                size: 20,
                                color: Colors.black,
                              )),
                          onTap: () {
                            Get.bottomSheet(const StockMedicinesList(),
                                isScrollControlled: true);
                          },
                          // onChanged: (value) {
                          //   controller.itemName = value;
                          // },
                        )));
              }),
              Obx(() {
                if (controller.inventory.value.items!.isEmpty) {
                  return Visibility(
                    visible: true,
                    child: Center(
                        child: Image.asset('assets/images/instock.jpg',
                            height: 300, width: 300)),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Text(
                          "Product :",
                          style: Get.textTheme.labelSmall!
                              .copyWith(color: Colors.teal.shade700),
                        ),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.inventory.value.items!.length,
                          itemBuilder: (context, index) {
                            final item =
                                controller.inventory.value.items![index];
                            return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(item.product!.name!,
                                                style: Get.textTheme.labelSmall!
                                                    .copyWith(
                                                        color: Colors
                                                            .grey.shade800),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1),
                                            SizedBox(height: 5),
                                            NoteItemWidget(onChanged: (value) {
                                              item.note = value;
                                            }),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            visualDensity: VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            onPressed: () {
                                              controller.reduceQuantity(item);
                                            },
                                            icon: Icon(
                                                HugeIcons
                                                    .strokeRoundedRemoveCircle,
                                                color: Colors.teal.shade700,
                                                size: 25),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            item.quantity.toString(),
                                            style: Get.textTheme.labelSmall,
                                          ),
                                          SizedBox(width: 5),
                                          IconButton(
                                            visualDensity: VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            onPressed: () {
                                              controller.addMedicine(item);
                                            },
                                            icon: Icon(
                                                HugeIcons
                                                    .strokeRoundedAddCircle,
                                                color: Colors.teal.shade700,
                                                size: 25),
                                          ),
                                          IconButton(
                                              visualDensity: VisualDensity(
                                                  horizontal: -4, vertical: -4),
                                              onPressed: () {
                                                controller.removeMedicine(item);
                                              },
                                              icon: Icon(
                                                HugeIcons.strokeRoundedDelete04,
                                                color: Colors.red,
                                                size: 20,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          }),
                    ],
                  );
                }
              }),
              Obx(() {
                return Visibility(
                    visible: controller.inventory.value.items!.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            Get.bottomSheet(
                              const StockMedicinesList(),
                              isScrollControlled: true,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Add Other Product",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Colors.teal.shade700,
                                          fontWeight: FontWeight.bold)),
                              Icon(
                                Icons.add,
                                color: Colors.teal.shade700,
                                size: 20,
                              ),
                            ],
                          )),
                    ));
              })
            ],
          ),
        ));
  }
}
