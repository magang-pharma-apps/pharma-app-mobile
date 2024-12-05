import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/modules/master/product/views/product_list_view.dart';
import 'package:medpia_mobile/app/modules/report/views/inventory_tab_view.dart';
import 'package:medpia_mobile/app/modules/report/views/report_view.dart';
import 'package:medpia_mobile/app/modules/stock/views/stock_view.dart';

class StockMenu extends StatelessWidget {
  const StockMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Inventory',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: 16)),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Icon(
                  HugeIcons.strokeRoundedFileValidation,
                  color: Colors.teal.shade800,
                ),
              ),
              title: Text('Stock Opname'),
              shape: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              subtitle: Text(
                  'Count and verify inventory to ensure accurate stock records.'),
              trailing: Icon(Icons.keyboard_arrow_right_rounded),
            ),
            ListTile(
              onTap: () {
                Get.to(StockView());
              },
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Icon(
                  HugeIcons.strokeRoundedPackageOutOfStock,
                  color: Colors.teal.shade800,
                ),
              ),
              title: Text('Inventory Adjustment'),
              shape: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              subtitle: Text(
                  'Adjust stock quantities to keep inventory accurate and up-to-date'),
              trailing: Icon(Icons.keyboard_arrow_right_rounded),
            ),
            ListTile(
              onTap: () {
                Get.to(ReportView());
              },
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Icon(
                  HugeIcons.strokeRoundedCardiogram01,
                  color: Colors.teal.shade800,
                ),
              ),
              title: Text('View Report'),
              shape: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              subtitle: Text(
                  'View and analyze your inventory data to make informed decisions.'),
              trailing: Icon(Icons.keyboard_arrow_right_rounded),
            ),
            ListTile(
              onTap: () {
                Get.to(ProductListView());
              },
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Icon(
                  HugeIcons.strokeRoundedMedicineSyrup,
                  color: Colors.teal.shade800,
                ),
              ),
              title: Text('Products'),
              shape: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              subtitle: Text(
                  'See all products in your inventory and manage them easily.'),
              trailing: Icon(Icons.keyboard_arrow_right_rounded),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.amber.shade700,
                ),
                title: Text(
                  "Key Notes",
                  style: Get.textTheme.labelSmall!
                      .copyWith(color: Colors.grey.shade700),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fitur ini membantu Anda mengelola stok barang dengan mudah.',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Image.asset('assets/images/inventory_illustration.jpg'),
            )
          ],
        ));
  }
}
