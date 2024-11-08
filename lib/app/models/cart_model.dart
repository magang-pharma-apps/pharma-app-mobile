import 'package:get_storage/get_storage.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';

class CartModel {
  List<CartItemModel>? items = [];
  double? subtotal;
  double? grandtotal;
  int? tax;
  String? paymentMethod;
  String? note;
  String? transactionDate;

  CartModel(
      {this.items,
      this.subtotal,
      this.grandtotal,
      this.tax,
      this.paymentMethod,
      this.note,
      this.transactionDate}); //karena dikasih kurawal maka ini disebut named parameter
  // Bisa diambil dengan tidak berurutan namun harus menyebutkan nama parameternya

  factory CartModel.transactionFromJson(Map<String, dynamic> json) {
    print(json);
    print('SUBTOTAL : ${json['subTotal']}');
    return CartModel(
      items: json['items'] is List
          ? List<CartItemModel>.from(
              json['items'].map((x) => CartItemModel.fromJson(x)))
          : [],
      subtotal: json['subTotal'] != null ? json['subTotal'].toDouble() : 0.0,
      grandtotal:
          json['grandTotal'] != null ? json['grandTotal'].toDouble() : 0.0,
      tax: json['tax'],
      paymentMethod: json['paymentMethod'],
      note: json['note'],
      transactionDate: json['transactionDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson({String transactionType = 'Generic'}) {
    return {
      'items': items!.map((item) => item.toJson()).toList(),
      'userId': GetStorage().read('userId'),
      'tax': tax,
      'subTotal': subtotal,
      'grandTotal': grandtotal,
      'transactionType': transactionType,
      'categoryType': 'Out', // VS In Stock (untuk enum di be )
      'transactionDate': DateTime.now().toIso8601String(),
      'paymentMethod': paymentMethod,
      'note': note,
    };
  }
}
