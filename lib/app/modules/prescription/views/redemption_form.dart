import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/cart_item.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_line_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/list_medicine_items_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/order_detail.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/search_widget.dart';
import 'package:medpia_mobile/app/modules/prescription/controllers/redemption_controller.dart';

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
                          Text(controller.prescription.value.medicines!.length.toString(),
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
                  onPressed: () {
                    // controller.createTransaction();
                  },
                  child: Text(
                    "Purchase Rp. 90000",
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
      appBar: AppBar(
        title: Text("Prescription Redemption"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Prescription Information",
                style: Theme.of(context).textTheme.displaySmall),
          ),
          ListTile(
            title: Text(
              formattedPrescriptionDate,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.teal),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Prescription Code: #${controller.prescription.value.prescriptionCode!}",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.teal.shade800, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber.shade50),
              child: Text(
                getPrescriptionStatus(controller.prescription.value.isRedeem!),
                style: TextStyle(color: Colors.amber.shade500),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Prescriptions',
              style: Theme.of(context).textTheme.labelMedium!,
            ),
            subtitle: Text(
              controller.prescription.value.prescriptions!,
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Pasien',
                    style: Theme.of(context).textTheme.labelMedium!),
                Text('Usia', style: Theme.of(context).textTheme.labelMedium!),
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
            title: Text(
              "Doctor",
              style: Theme.of(context).textTheme.labelMedium!,
            ),
            trailing: Text(
              controller.prescription.value.doctor!.name!,
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.bottomSheet(const ListMedicineItemsWidget());
            },
            style:
                ElevatedButton.styleFrom(fixedSize: Size(Get.width * 0.8, 30)),
            child: const Text("Add Medicine Items"),
          ),
          ListTile(
              title: Text("Medicine Items",
                  style: Theme.of(context).textTheme.displaySmall)),
          Expanded(
            child: Obx(() {
              return controller.prescription.value.medicines!.isEmpty
                  ? const Center(child: Text("No Medicine Added"))
                  : ListView.builder(
                      // shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount:
                          controller.prescription.value.medicines!.length,
                      itemBuilder: (context, index) {
                        final product =
                            controller.prescription.value.medicines![index];
                        return CartItem(
                          cartItemModel: product,
                          onQtyChange: () {
                            // controller.calculateSubtotal();
                            // controller.calculateTax();
                            // controller.calculateGrandtotal();
                          },
                        );
                      },
                    );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: 

            OrderDetail(),
          )
        ],
      ),
    );
  }
}
