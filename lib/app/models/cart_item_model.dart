import 'package:medpia_mobile/app/models/product_model.dart';

class CartItemModel{
  ProductModel? product;
  int? quantity;
  String? note;

  CartItemModel({this.product, this.quantity, this.note});
}