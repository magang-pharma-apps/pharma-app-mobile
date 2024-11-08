import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/cart_model.dart';
import 'package:medpia_mobile/app/models/prescription_model.dart';
import 'package:medpia_mobile/app/modules/prescription/views/prescription_screen.dart';
import 'package:medpia_mobile/app/repositories/prescription_repository.dart';
import 'package:medpia_mobile/app/repositories/transaction_repository.dart';

class RedemptionController extends GetxController {
  final prescriptionRepository = PrescriptionRepository();
  Rx<PrescriptionModel> prescription = PrescriptionModel().obs;

  @override
  void onInit() {
    super.onInit();
    prescription.value = Get.arguments;
    prescription.value.cart = CartModel(
      items: <CartItemModel>[].obs,
      subtotal: 0,
      grandtotal: 0,
      tax: 0,
      paymentMethod: 'Cash',
      note: '',
    );
  }

  void calculateSubtotal() {
    double subtotal = 0;
    for (var item in prescription.value.cart!.items!) {
      subtotal += item.product!.sellingPrice! * item.quantity!;
    }
    prescription.value.cart!.subtotal = subtotal;
    // print(prescription.value.cart!.subtotal);
    prescription.refresh();
  }

  void calculateTax() {
    prescription.value.cart!.tax =
        (prescription.value.cart!.subtotal! * 0.1).toInt();
    prescription.refresh();
  }

  void calculateGrandtotal() {
    prescription.value.cart!.grandtotal =
        prescription.value.cart!.subtotal! + prescription.value.cart!.tax!;
    prescription.refresh();
  }

  void removeItemFromCart(CartItemModel item) {
    prescription.value.cart!.items!
        .removeWhere((element) => element.product!.id == item.product!.id);
    calculateSubtotal();
    calculateTax();
    calculateGrandtotal();
    prescription.refresh();
  }

  void selectPaymentMethod(String paymentMethod) {
    // logic untuk memilih payment method
    prescription.value.cart!.paymentMethod = paymentMethod;
    prescription.refresh();
  }

  void createRedemption() async {
    try {
      final isCreated = await prescriptionRepository
          .createRedemption(prescription.value.toJson());
          
      if (isCreated) {
        CustomSnackbar.showSnackbar(Get.context!,
            message: "Prescription successfully redeemed",
            title: "Success!",
            contentType: ContentType.success);
        Get.back(result: true);
      } else {
        CustomSnackbar.showSnackbar(Get.context!,
            message: "Failed to created transaction",
            title: "Failed!",
            contentType: ContentType.failure);
      }
    } catch (e) {
      print("Error Redeem Payment $e");
    }
  }
}
