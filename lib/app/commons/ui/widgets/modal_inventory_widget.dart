import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/modules/stock/controllers/stock_controller.dart';
import 'package:medpia_mobile/app/modules/stock/controllers/stock_list_controller.dart';
import 'package:medpia_mobile/app/modules/stock/views/stock_in_form.dart';
import 'package:medpia_mobile/app/modules/stock/views/stock_out_form.dart';

class ModalInventoryWidget extends GetView<StockController> {
  const ModalInventoryWidget({
    super.key,
  });

  @override
  get controller => Get.put(StockController());
  // TODO: implement controller

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30,
            width: Get.width,
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              dense: true,
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Select Stock Type',
                  style: Theme.of(context).textTheme.labelMedium),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.grey,
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: 50,
              child: ListTile(
                titleTextStyle: Theme.of(context).textTheme.bodySmall,
                style: ListTileStyle.drawer,
                leading: Icon(HugeIcons.strokeRoundedInformationCircle),
                title: Text(
                    "Choose an option below to update the stock status for your inventory."),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelMedium,
                  fixedSize: Size(Get.width, 50),
                  backgroundColor: Colors.teal.shade900,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                Get.back();
                controller.clearForm();

                // Navigator.pop(context);
                Get.to(() => const StockInForm())?.then((result) {
                  if (result == true) {
                    controller.getInventories();
                  }
                });
              },
              child: Text('Stock In')),
          SizedBox(height: 7),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelMedium,
                  fixedSize: Size(Get.width, 50),
                  backgroundColor: Color(0xff740938),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                Get.back();
                controller.clearForm();

                // Navigator.pop(context);
                Get.to(() => const StockOutForm())?.then((result) {
                  if (result == true) {
                    controller.getInventories();
                  }
                });
              },
              child: Text('Stock Out')),
        ],
      ),
    );
  }
}
