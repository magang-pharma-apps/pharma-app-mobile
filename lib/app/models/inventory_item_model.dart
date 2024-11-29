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
      note: json['noteItem'] ?? '',
      quantity: json['qtyItem'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': product!.id,
      'qtyItem': quantity,
      'noteItem': note,
    };
  }
}
