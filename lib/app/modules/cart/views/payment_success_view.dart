import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/core_view.dart';
import 'package:medpia_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:medpia_mobile/app/modules/home/views/home_view.dart';

class PaymentSuccessView extends StatelessWidget {
  final Map<String, dynamic> data;
  const PaymentSuccessView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.offAll(CoreView());
          },
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            height: Get.height * 0.3,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/check.jpg",
                  width: 100,
                ),
                Text(
                  "Payment Successful",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  "Successfully paid Rp.${data['grandTotal'].toInt()}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey.shade600),
                )
              ],
            )),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Detail Payment",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  title: Text("Date"),
                  trailing: Text(DateFormat('d MMMM yyyy')
                      .format(DateTime.parse(data['transactionDate']))),
                ),
                ListTile(
                  dense: true,
                  title: Text("Type of Transaction"),
                  trailing: Text(data['transactionType']),
                ),
                ListTile(
                  dense: true,
                  title: Text("Payment Method"),
                  trailing: Text(data['paymentMethod']),
                ),
                ListTile(
                  dense: true,
                  title: Text("Sub Total"),
                  trailing: Text("Rp.${data['subTotal'].toInt()}"),
                ),
                ListTile(
                  dense: true,
                  title: Text("Tax (PPN 10%)"),
                  trailing: Text("Rp.${data['tax'].toInt()}"),
                ),
                ListTile(
                  dense: true,
                  title: Text("Nominal Total"),
                  trailing: Text("Rp.${data['grandTotal'].toInt()}"),
                ),
                ListTile(
                  dense: true,
                  title: Text("Note"),
                  trailing: Text(
                      data['note'] == '' ? 'Tidak ada catatan' : data['note']),
                ),
                ListTile(
                  dense: true,
                  title: Text("Cashier"),
                  trailing: Text(GetStorage().read('username')),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.print),
                    Text(
                      "  Print Invoice",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.white),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
