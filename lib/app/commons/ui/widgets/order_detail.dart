import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/modules/cart/controllers/cart_controller.dart';

class OrderDetail extends GetView<CartController> {
  OrderDetail({
    super.key,
  });

  @override
  get controller => Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
          child: Text("Order Info",
              textHeightBehavior: TextHeightBehavior(
                  applyHeightToLastDescent: true,
                  applyHeightToFirstAscent: true),
              style: Theme.of(context).textTheme.labelMedium),
        ),
        SizedBox(
          height: 20,
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sub Total",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textHeightBehavior: TextHeightBehavior(
                      applyHeightToLastDescent: true,
                      applyHeightToFirstAscent: true),
                ),
                Text('Rp ${controller.cart.value.subtotal!.toInt()}',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            );
          }),
        ),
        SizedBox(
          height: 20,
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "PPN 10%",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textHeightBehavior: TextHeightBehavior(
                      applyHeightToLastDescent: true,
                      applyHeightToFirstAscent: true),
                ),
                Text("Rp ${controller.cart.value.tax}",
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            );
          }),
        ),
        SizedBox(
          height: 20,
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  textHeightBehavior: TextHeightBehavior(
                      applyHeightToLastDescent: true,
                      applyHeightToFirstAscent: true),
                ),
                Text(
                  "Rp ${controller.cart.value.grandtotal!.toInt()}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            );
          }),
        ),
      ],
    );
  }
}
