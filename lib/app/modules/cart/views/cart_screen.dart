import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_line_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/note_order_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/cart_item.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/order_detail.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

// Get View ini generic class dari getX bis adikasi type data, type data dari controller
class CartScreen extends GetView<CartController> {
  CartScreen({super.key});

  @override
  get controller => Get.put(
      CartController()); // fungsi get put, melakukan binding dari controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Container(
          padding: EdgeInsets.all(10),
          child: Obx(() {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("You've Added",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.grey.shade800)),
                      Row(
                        children: [
                          Text(controller.cart.value.items!.length.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.green)),
                          Text(" Items",
                              style: Theme.of(context).textTheme.labelMedium)
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Purchase Rp. ${controller.cart.value.grandtotal}",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20)),
                ),
              ],
            );
          }),
        )
      ],
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    appBarTitle: "Process Transaction",
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Obx(() {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.cart.value.items!.length,
                        itemBuilder: (context, index) {
                          final product = controller.cart.value.items![index];
                          return CartItem(
                            cartItemModel: product,
                            onQtyChange: () {
                              controller.calculateSubtotal();
                              controller.calculateTax();
                              controller.calculateGrandtotal();
                            },
                          );
                        },
                      );
                    }),
                  ),
                  ListTile(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 170,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(
                                      "Choose Payment Method",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(HugeIcons
                                            .strokeRoundedMultiplicationSign)),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      controller.selectPaymentMethod("Cash");

                                      // setState(() {
                                      //   // selectPayment("Cash");
                                      Navigator.pop(context);
                                      // });
                                    },
                                    leading:
                                        Icon(HugeIcons.strokeRoundedWallet01),
                                    title: Text("Cash"),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      controller.selectPaymentMethod("Debit");
                                      // setState(() {
                                      //   selectPayment("Debit");
                                      Navigator.pop(context);
                                      // });
                                    },
                                    leading:
                                        Icon(HugeIcons.strokeRoundedCreditCard),
                                    title: Text("Debit"),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(HugeIcons.strokeRoundedPayment01),
                    title: Text("Payment Method",
                        style: Theme.of(context).textTheme.labelSmall!),
                    trailing: SizedBox(
                      width: 100,
                      child: Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              controller.cart.value.paymentMethod!,
                              // '${_selectedPayment}',
                              // style: TextStyle(fontSize: 10, color: Colors.teal),
                            ),
                            Icon(
                              HugeIcons.strokeRoundedArrowRight01,
                              color: Colors.teal,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  CustomLineWidget(),
                  NoteOrderWidget(),
                ]),
            CustomLineWidget(),
            SizedBox(height: 10),
            OrderDetail(),
          ],
        ),
      ),
    );
  }
}
