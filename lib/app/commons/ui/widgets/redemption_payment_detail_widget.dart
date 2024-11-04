import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:medpia_mobile/app/modules/prescription/controllers/redemption_controller.dart';

class RedemptionPaymentDetailWidget extends StatelessWidget {
  const RedemptionPaymentDetailWidget({
    super.key,
    required this.controller,
  });

  final RedemptionController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
          child: Text("Payment Info",
              textHeightBehavior: TextHeightBehavior(
                  applyHeightToLastDescent: true,
                  applyHeightToFirstAscent: true),
              style: Theme.of(context).textTheme.displaySmall),
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
                Text('Rp ${controller.prescription.value.cart!.subtotal}',
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
                Text("Rp ${controller.prescription.value.cart!.tax}",
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
                  "Rp ${controller.prescription.value.cart!.grandtotal}",
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
