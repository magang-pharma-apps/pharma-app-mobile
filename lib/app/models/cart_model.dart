import 'package:get_storage/get_storage.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';

class CartModel {
  List<CartItemModel>? items = [];
  double? subtotal;
  double? grandtotal;
  int? tax;
  String? paymentMethod;
  String? note;

  CartModel(
      {this.items,
      this.subtotal,
      this.grandtotal,
      this.tax,
      this.paymentMethod,
      this.note}); //karena dikasih kurawal maka ini disebut named parameter
  // Bisa diambil dengan tidak berurutan namun harus menyebutkan nama parameternya

  Map<String, dynamic> toJson({String transactionType = 'Generic Drugs'}) {
    return {
      'items': items!.map((item) => item.toJson()).toList(),
      'userId': GetStorage().read('userId'),
      'tax': tax,
      'subTotal': subtotal,
      'grandTotal': grandtotal,
      'transactionType': transactionType, 
      'categoryType': 'Out Stock', // VS In Stock (untuk enum di be )
      'transactionDate': DateTime.now().toIso8601String(),
      'paymentMethod': paymentMethod,
      'note': note,
    };
  }
}
