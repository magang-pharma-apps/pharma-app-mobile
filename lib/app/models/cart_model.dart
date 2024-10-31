import 'package:medpia_mobile/app/models/cart_item_model.dart';

class CartModel {
  List<CartItemModel>? items = [];
  double? subtotal;
  double? grandtotal;
  int? tax;
  String? paymentMethod;
  String? note;

  CartModel({this.items, this.subtotal, this.grandtotal, this.tax, this.paymentMethod, this.note}); //karena dikasih kurawal maka ini disebut named parameter
  // Bisa diambil dengan tidak berurutan namun harus menyebutkan nama parameternya
}
