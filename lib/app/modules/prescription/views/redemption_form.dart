import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/cart_item.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_line_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/list_medicine_items_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/order_detail.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/redemption_payment_detail_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/search_widget.dart';
import 'package:medpia_mobile/app/modules/prescription/controllers/redemption_controller.dart';
import 'package:medpia_mobile/app/modules/prescription/views/prescription_view.dart';

String getPrescriptionStatus(bool status) {
  switch (status) {
    case true:
      return 'Redeemed';
    default:
      return 'Unreedemed';
  }
}

class RedemptionForm extends GetView<RedemptionController> {
  
  
  const RedemptionForm({super.key});

  @override
  get controller => Get.put(RedemptionController());

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate =
        DateTime.parse(controller.prescription.value.prescriptionDate!);
    String formattedPrescriptionDate =
        DateFormat('MM/dd/yyyy hh:mm:ss a').format(parsedDate);
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
                          Text(
                              controller.prescription.value.cart!.items!.length
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.green)),
                          Text(" Items",
                              style: Theme.of(context).textTheme.labelSmall)
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible:
                      controller.prescription.value.cart!.items!.isNotEmpty,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.createRedemption();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15)),
                    child: Text(
                      "Purchase Rp. ${controller.prescription.value.cart!.grandtotal!.toInt()}",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }),
        )
      ],
      appBar: AppBar(
          title: Text("Prescription Redemption",
              style: Theme.of(context).textTheme.labelMedium)),
      body: ListView(
        children: [
          Container(
            width: Get.width,
            height: 30,
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10, right: 10),
              visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
              title: Text("Prescription Information",
                  style: Theme.of(context).textTheme.labelMedium),
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            title: Text(
              formattedPrescriptionDate,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.teal),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Prescription Code: #${controller.prescription.value.prescriptionCode!}",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.teal.shade800, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: Container(
              margin: EdgeInsets.only(right: 2),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber.shade50),
              child: Text(
                getPrescriptionStatus(controller.prescription.value.isRedeem!),
                style: TextStyle(color: Colors.amber.shade500, fontSize: 11),
              ),
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            title: Text(
              'Prescriptions',
              style: Theme.of(context).textTheme.labelSmall!,
            ),
            subtitle: Text(
              controller.prescription.value.prescriptions!,
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Pasien',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                Text('Usia',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  controller.prescription.value.customer!.name!,
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
                Text(
                  controller.prescription.value.customer!.age!.toString(),
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
              ],
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            title: Text(
              "Doctor",
              style: Theme.of(context).textTheme.labelSmall!,
            ),
            trailing: Text(
              controller.prescription.value.doctor!.name!,
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ElevatedButton(
              onPressed: () {
                Get.bottomSheet(const ListMedicineItemsWidget());
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(Get.width * 0.9, 15)),
              child: Text(
                "Add Medicine Items",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          ListTile(
              splashColor: Colors.grey.shade200,
              dense: true,
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.only(left: 10, right: 10),
              title: Text("Medicine Items",
                  style: Theme.of(context).textTheme.labelMedium)),
          Obx(() {
            return controller.prescription.value.cart!.items!.isEmpty
                ? const Center(
                    child: Image(
                    image: AssetImage('assets/images/obat.png'),
                  ))
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount:
                        controller.prescription.value.cart!.items!.length,
                    itemBuilder: (context, index) {
                      final product =
                          controller.prescription.value.cart!.items![index];
                      return CartItem(
                        cartItemModel: product,
                        onRemove: () {
                          controller.removeItemFromCart(product);
                        },
                        onQtyChange: () {
                          controller.calculateSubtotal();
                          controller.calculateTax();
                          controller.calculateGrandtotal();
                        },
                      );
                    },
                  );
          }),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 10, right: 10),
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
                            title: const Text(
                              "Choose Payment Method",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                    HugeIcons.strokeRoundedMultiplicationSign)),
                          ),
                          ListTile(
                            onTap: () {
                              controller.selectPaymentMethod("Cash");

                              // setState(() {
                              //   // selectPayment("Cash");
                              Navigator.pop(context);
                              // });
                            },
                            leading: Icon(HugeIcons.strokeRoundedWallet01),
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
                            leading: Icon(HugeIcons.strokeRoundedCreditCard),
                            title: Text("Debit"),
                          ),
                        ],
                      ),
                    );
                  });
            },
            leading: Icon(HugeIcons.strokeRoundedPayment01),
            title: Text("Payment Method",
                style: Theme.of(context).textTheme.bodyMedium!),
            trailing: SizedBox(
              width: 100,
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      controller.prescription.value.cart!.paymentMethod!,
                      // '${_selectedPayment}',
                      // style: TextStyle(fontSize: 10, color: Colors.teal),
                    ),
                    Icon(
                      HugeIcons.strokeRoundedArrowRight01,
                      color: Colors.black,
                    ),
                  ],
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: RedemptionPaymentDetailWidget(controller: controller),
          )
        ],
      ),
    );
  }
}
