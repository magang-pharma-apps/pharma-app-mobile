import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/modules/stock/controllers/stock_controller.dart';

class ProductOptionsWidget extends StatelessWidget {
  const ProductOptionsWidget({
    super.key,
    required this.controller,
  });

  final StockController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                        'Sesuaikan jumlah stok dengan jumlah fisik yang ada di gudang pada kolom "Real Stock"',
                        style: Get.textTheme.bodySmall!
                            .copyWith(color: Colors.grey.shade800)),
                  ))
            ],
          ),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.inventory.value.items!.length,
            itemBuilder: (context, index) {
              final item = controller.inventory.value.items![index];
              return Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.product!.name!,
                                  style: Get.textTheme.labelSmall!
                                      .copyWith(color: Colors.grey.shade800),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1),
                              Text(
                                  'Current Stock: ${item.product!.stockQuantity!.toString()}',
                                  style: Get.textTheme.bodyMedium!
                                      .copyWith(color: Colors.blue.shade800),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1),
                              Text('Discrepancy: ${item.discrepancy}',
                                  style: Get.textTheme.bodyMedium!
                                      .copyWith(color: Colors.blue.shade800),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1),
                              Text(
                                'Exp Date: ${DateFormat('dd/MM/yy').format(DateTime.parse(item.product!.expiryDate!))}',
                                style: Get.textTheme.bodyMedium!.copyWith(
                                    color: item.product!.expiryCategory),
                              ),
                              const SizedBox(height: 5),
                              // NoteItemWidget(onChanged: (value) {
                              //   item.note = value;
                              // }
                              // ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text('Real Stock',
                                style: Get.textTheme.labelSmall!.copyWith(
                                    color: Colors.teal.shade700, fontSize: 10)),
                            Row(
                              children: [
                                IconButton(
                                  visualDensity: const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  onPressed: () {
                                    item.quantity != 0
                                        ? controller.reduceQuantity(item, 0)
                                        : controller.removeMedicine(item);
                                  },
                                  icon: item.quantity != 0
                                      ? Icon(
                                          HugeIcons.strokeRoundedRemoveCircle,
                                          color: Colors.teal.shade700,
                                          size: 20)
                                      : Icon(
                                          HugeIcons.strokeRoundedDelete04,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                ),
                                SizedBox(
                                  width: 35,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
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
                                      // // Tambahkan logika untuk memperbarui nilai jika diperlukan
                                      item.quantity = int.parse(value);
                                      controller.calculateDiscrepancy(item);
                                      item.physicalStock = item.quantity;
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      TextInputFormatter.withFunction(
                                          (oldValue, newValue) {
                                        if (newValue.text.isEmpty) {
                                          return TextEditingValue(
                                              text: '0',
                                              selection:
                                                  TextSelection.collapsed(
                                                      offset: 1));
                                        }
                                        return newValue;
                                      })
                                    ],
                                  ),
                                ),
                                IconButton(
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  onPressed: () {
                                    controller.addMedicine(item);
                                  },
                                  icon: Icon(HugeIcons.strokeRoundedAddCircle,
                                      color: Colors.teal.shade700, size: 20),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ));
            }),
      ],
    );
  }
}
