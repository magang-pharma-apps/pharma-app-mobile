import 'package:medpia_mobile/app/models/cart_item_model.dart';

class CartModel {
  List<CartItemModel>? items = [];
  double? subtotal;
  double? grandtotal;
  int? tax;
  String? paymentMethod;
  String? note;

  CartModel(
      {
      this.items,
      this.subtotal,
      this.grandtotal,
      this.tax,
      this.paymentMethod,
      this.note}); //karena dikasih kurawal maka ini disebut named parameter
  // Bisa diambil dengan tidak berurutan namun harus menyebutkan nama parameternya

  Map<String, dynamic> toJson() {
    return {
      'items': items!.map((item) => item.toJson()).toList(),
      'userId': "95d1e1f3-9adc-46c0-8638-c018369b1f10",
      'tax': tax,
      'subTotal': subtotal,
      'grandTotal': grandtotal,
      'transactionType': 'purchase',
      'categoryType': 'transaction',
      'transactionDate': DateTime.now().toIso8601String(),
      'paymentMethod': paymentMethod,
      'note': note,
    };
  }
}
