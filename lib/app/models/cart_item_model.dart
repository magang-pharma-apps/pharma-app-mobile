import 'package:medpia_mobile/app/models/product_model.dart';

class CartItemModel {
  ProductModel? product;
  int? quantity;
  String? note;

  CartItemModel({this.product, this.quantity, this.note});

  Map<String, dynamic> toJson() {
    return {
      'productId': product!.id,
      'quantity': quantity,
      'note': note,
      // 'total_price': product!.sellingPrice! * quantity!,
    };
  }
}
