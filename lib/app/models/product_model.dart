import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/models/unit_model.dart';

class ProductModel {
  int? id;
  UnitModel? unit;
  CategoryModel? category;
  String? productCode;
  String? name;
  double? purchasePrice;
  double? sellingPrice;
  int? stockQuantity;
  String? description;
  String? expiryDate;
  String? productImageUrl;
  String? drugClass;

  ProductModel({
    this.id,
    this.productCode,
    this.name,
    this.description,
    this.purchasePrice,
    this.sellingPrice,
    this.expiryDate,
    this.stockQuantity,
    this.category,
    this.unit,
    this.productImageUrl,
    this.drugClass,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        productCode: json['productCode'],
        name: json['name'],
        description: json['description'],
        purchasePrice: json['purchasePrice'],
        sellingPrice: json['sellingPrice'],
        expiryDate: json['expiryDate'],
        stockQuantity: json['stockQuantity'],
        category: json['category'] != null
            ? CategoryModel.fromJson(json['category'])
            : null,
        unit: json['unit'] != null ? UnitModel.fromJson(json['unit']) : null,
        productImageUrl: json['productImageUrl'],
        drugClass: json['drugClass']);
  }
}
