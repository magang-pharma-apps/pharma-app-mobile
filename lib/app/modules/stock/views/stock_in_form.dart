import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/list_medicine_items_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/note_item_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/note_prescription.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/cart_model.dart';
import 'package:medpia_mobile/app/models/inventory_item_model.dart';
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
                  fixedSize: Size(Get.width, 20),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
              onPressed: () {
                controller.createStockIn();
              },
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
                child: Obx(() {
                  return TextFormField(
                    controller: TextEditingController()
                      ..text = controller.formattedDateTime,
                    readOnly: true,
                    onTap: () async {
                      await controller.pickDate(context);
                      await controller
                          .pickTime(context); // Memilih waktu setelah tanggal
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
              DropdownButtonFormField<String>(
                  isExpanded: true,
                  padding: EdgeInsets.all(8),
                  dropdownColor: Colors.white,
                  decoration: const InputDecoration(
                    labelText: 'Reason',
                  ),
                  value: controller.inventory.value.reasonType,
                  style: const TextStyle(color: Colors.black),
                  items: ['Purchase', 'Replacement', 'Bonus']
                      .map((String drugClass) {
                    return DropdownMenuItem<String>(
                      value: drugClass,
                      child: Text(drugClass),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    controller.inventory.value.reasonType = value;
                  }),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Description (optional)',
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Product :",
                              style: Get.textTheme.labelSmall!
                                  .copyWith(color: Colors.teal.shade700),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    HugeIcons.strokeRoundedAlert01,
                                    color: Colors.red.shade700,
                                    size: 20,
                                  ),
                                  title: Text(
                                      'Kuantitas yang diinputkan dibawah akan MENAMBAH jumlah ketersediaan stok produk',
                                      style: Get.textTheme.bodySmall!.copyWith(
                                          color: Colors.grey.shade800)),
                                ))
                          ],
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
                                            Text(
                                                'Current Stock: ${item.product!.stockQuantity!.toString()}',
                                                style: Get.textTheme.bodySmall!
                                                    .copyWith(
                                                        color: Colors
                                                            .grey.shade800),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1),
                                            const SizedBox(height: 5),
                                            NoteItemWidget(onChanged: (value) {
                                              item.note = value;
                                            }),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            visualDensity: const VisualDensity(
                                                horizontal: 0, vertical: -4),
                                            onPressed: () {
                                              controller.reduceQuantity(item, 1);
                                            },
                                            icon: Icon(
                                                HugeIcons
                                                    .strokeRoundedRemoveCircle,
                                                color: Colors.teal.shade700,
                                                size: 25),
                                          ),
                                          SizedBox(
                                            width: 20,
                                            child: TextFormField(
                                              controller: TextEditingController(
                                                  text: item.quantity
                                                      ?.toString()), // Mengisi nilai awal
                                              style: Get.textTheme
                                                  .labelSmall, // Menyesuaikan gaya teks
                                              decoration: const InputDecoration(
                                                enabledBorder: InputBorder.none,

                                                border: InputBorder
                                                    .none, // Menghapus border di sekitar TextFormField
                                                isDense:
                                                    true, // Mengurangi padding default
                                                contentPadding: EdgeInsets
                                                    .zero, // Menghilangkan padding tambahan
                                              ),
                                              keyboardType: TextInputType
                                                  .number, // Keyboard angka untuk input kuantitas
                                              onChanged: (value) {
                                                item.quantity =
                                                    int.parse(value);
                                              },
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                TextInputFormatter.withFunction(
                                                    (oldValue, newValue) {
                                                  if (newValue.text.isEmpty) {
                                                    return newValue.copyWith(
                                                        text: '1',
                                                        selection:
                                                            const TextSelection
                                                                .collapsed(
                                                                offset: 1));
                                                  }
                                                  return newValue.copyWith(
                                                      text: newValue.text);
                                                })
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            visualDensity: const VisualDensity(
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
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: -4,
                                                      vertical: -4),
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
