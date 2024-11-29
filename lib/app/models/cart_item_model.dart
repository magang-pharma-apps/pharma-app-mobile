import 'package:medpia_mobile/app/commons/utils/format_rupiah.dart';
import 'package:medpia_mobile/app/models/product_model.dart';

class CartItemModel {
  ProductModel? product;
  int? quantity;
  String? note;

  CartItemModel({this.product, this.quantity, this.note});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
      quantity: json['quantity'] ?? 0,
      note: json['note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': product!.id,
      'quantity': quantity,
      'note': note,
    };
  }

  String get productLabel => '$quantity x ${product!.name ?? ''}';

  String get productPrice => FormatRupiah.format(product?.sellingPrice! ?? 0);

  String get totalPrice =>
      FormatRupiah.format(product!.sellingPrice! * quantity!);
}
