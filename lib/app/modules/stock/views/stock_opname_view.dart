import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/utils/scan_qr.dart';
import 'package:medpia_mobile/app/modules/stock/controllers/stock_controller.dart';

class StockOpnameView extends GetView<StockController> {
  const StockOpnameView({super.key});

  

  @override
  get controller => Get.put(StockController());

  void setResult(String result) {
    // Handle the result from the QR scan
    print("QR Scan Result: $result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal.shade800,
        onPressed: () {
          ScanQr(setResult: setResult);
        },
        child: Icon(
          HugeIcons.strokeRoundedQrCode,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: Text(
          "Stock Opname",
          style: Theme.of(context).textTheme.labelMedium!,
        ),
      ),
      body: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            final currentDate = DateTime.now();
            final expiryDate = DateTime.parse(product.expiryDate!);

            // Calculate difference between expiry date and current date
            final differenceInDays = expiryDate.difference(currentDate).inDays;

            // Determine color based on expiry status
            Color expiryColor;
            if (differenceInDays < 0) {
              // Already expired
              expiryColor = Colors.red;
            } else if (differenceInDays <= 30) {
              // Will expire within 1 month
              expiryColor = Colors.orange;
            } else {
              // Not expired yet
              expiryColor = Colors.blue.shade800;
            }

            Color stockColor = conditionColor(product.stockQuantity!);

            return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.tealAccent.shade700,
                  child: Icon(
                    HugeIcons.strokeRoundedMedicineBottle01,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                shape: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                title: Text(
                  product.name!,
                  style: Get.textTheme.labelSmall!,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SKU: ${product.productCode}',
                      style: Get.textTheme.bodyMedium!
                          .copyWith(color: Colors.blue.shade800),
                    ),
                    Text(
                      'Stock: ${product.stockQuantity} ${product.unit!.name}',
                      style:
                          Get.textTheme.bodyMedium!.copyWith(color: stockColor),
                    ),
                    Text(
                      'Exp Date: ${DateFormat('dd/MM/yy').format(DateTime.parse(product.expiryDate!))}',
                      style: Get.textTheme.bodyMedium!
                          .copyWith(color: expiryColor),
                    ),
                  ],
                ));
          },
        );
      }),
    );
  }

  Color conditionColor(int stockQuantity) {
    if (stockQuantity == 0) {
      return Colors.red; // Stock habis
    } else if (stockQuantity <= 15) {
      return Colors.orange; // Stock hampir habis
    } else {
      return Colors.blue.shade800; // Stock aman
    }
  }

}
