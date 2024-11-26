import 'package:medpia_mobile/app/models/product_model.dart';

class InventoryItemModel {
  ProductModel? product;
  int? quantity;
  String? note;

  InventoryItemModel({this.product, this.quantity, this.note});

  factory InventoryItemModel.fromJson(Map<String, dynamic> json) {
    return InventoryItemModel(
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



}
