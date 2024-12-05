import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/cart_model.dart';
import 'package:medpia_mobile/app/modules/cart/views/payment_success_view.dart';
import 'package:medpia_mobile/app/modules/report/controllers/report_controller.dart';
import 'package:medpia_mobile/app/repositories/transaction_repository.dart';

class CartController extends GetxController {
  final transactionRespository = TransactionRepository();
  final reportController = Get.put(ReportController());
  RxInt cartQuantityItem = 0.obs;
  
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  GlobalKey<CartIconKey> cartKeyHome = GlobalKey<CartIconKey>();
  GlobalKey<CartIconKey> cartKeyDetail = GlobalKey<CartIconKey>();

  // isinya semua state yang ada di dalam ui nya
  Rx<CartModel> cart = CartModel(
          items: [],
          subtotal: 0,
          grandtotal: 0,
          tax: 0,
          paymentMethod: 'Cash',
          note: "")
      .obs;
  // cart ini akan dinamis, supaya bisa melacak perubahannya
  // maka perlu mengubah tipe data dari CartModel menjadi Rx<CartModel>
  // dan tambahkan .obs di belakangnya supaya bisa observable (bisa di track perubahannya)

  void addItemToCart(CartItemModel item) {
    // logic untuk menambahkan item ke cart
    final index = cart.value.items!
        .indexWhere((element) => element.product!.id == item.product!.id);

    if (index >= 0) {
      // jika item sudah ada di cart, maka tambahkan quantity nya
      cart.value.items![index].quantity =
          cart.value.items![index].quantity! + 1;
    } else {
      // jika item belum ada di cart, maka tambahkan itemnya
      cart.value.items!.add(item);
    }
    calculateSubtotal();
    calculateTax();
    calculateGrandtotal();
    calculateTotalQuantity();

    cart.refresh();
  }

  void selectPaymentMethod(String paymentMethod) {
    // logic untuk memilih payment method
    cart.value.paymentMethod = paymentMethod;
    cart.refresh();
  }

  void calculateSubtotal() {
    double subtotal = 0;
    for (var item in cart.value.items!) {
      subtotal += item.product!.sellingPrice! * item.quantity!;
    }
    cart.value.subtotal = subtotal;
    cart.refresh();
  }

  void calculateTax() {
    // logic untuk menghitung pajak
    cart.value.tax = (cart.value.subtotal! * 0.1).toInt();
    cart.refresh();
  }

  void calculateGrandtotal() {
    cart.value.grandtotal = cart.value.subtotal! + cart.value.tax!;
    cart.refresh();
  }

  void removeItemFromCart(CartItemModel item) {
    // logic untuk menghapus item dari cart
    cart.value.items!
        .removeWhere((element) => element.product!.id == item.product!.id);
    calculateSubtotal();
    calculateTax();
    calculateGrandtotal();
    calculateTotalQuantity();
    if (cart.value.items!.length == 0) {
      cart.value.items = [];
    }
    cart.refresh();
  }

  void createTransaction() async {
    try {
      final isCreated =
          await transactionRespository.createTransaction(cart.value.toJson());
      if (isCreated) {
        Get.dialog(PaymentSuccessView(data: cart.value.toJson()));
        reportController.getTransactions();
      } else {
        CustomSnackbar.showSnackbar(Get.context!,
            message: "Failed to created transaction",
            title: "Failed!",
            contentType: ContentType.failure);
      }
    } catch (e) {
      // TODO
      print("Error transaction $e");
    }
  }

  void calculateTotalQuantity() {
    int totalQuantity = 0;
    for (var item in cart.value.items!) {
      totalQuantity += item.quantity!;
    }
    cartQuantityItem.value = totalQuantity;
  }
}
