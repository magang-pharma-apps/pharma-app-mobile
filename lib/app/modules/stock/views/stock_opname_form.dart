import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/product_options_widget.dart';
import 'package:medpia_mobile/app/modules/stock/controllers/stock_controller.dart';
import 'package:medpia_mobile/app/modules/stock/views/stock_medicines_list.dart';

class StockOpnameForm extends GetView<StockController> {
  const StockOpnameForm({super.key});

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
              onPressed: () {
                controller.createOpname();
              },
              child: Text('Save')),
        ],
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Stock Opname Form',
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
                child: Obx(() {
                  return TextFormField(
                    controller: TextEditingController()
                      ..text = controller.formattedDate,
                    readOnly: true,
                    onTap: () async {
                      await controller.pickDate(context);
                      // Memilih waktu setelah tanggal
                    },
                    decoration: InputDecoration(
                        hintText: 'Select Date & Time',
                        labelText: 'Date & Time',
                        suffixIcon: Icon(
                          HugeIcons.strokeRoundedCalendar02,
                          color: Colors.black,
                        )),
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Note/Reason',
                      hintText: 'Write a note',
                      suffixIcon: Icon(
                        HugeIcons.strokeRoundedStickyNote02,
                        size: 20,
                        color: Colors.black,
                      )),
                  onChanged: (value) {
                    controller.inventory.value.note = value;
                  },
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
                  return ProductOptionsWidget(controller: controller);
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
