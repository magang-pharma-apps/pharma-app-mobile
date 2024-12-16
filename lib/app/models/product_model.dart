import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/enums/expiry_standard.dart';
import 'package:medpia_mobile/app/commons/enums/stock_standard.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/models/inventory_item_model.dart';
import 'package:medpia_mobile/app/models/inventory_model.dart';
import 'package:medpia_mobile/app/models/unit_model.dart';

class ProductModel {
  int? id;
  UnitModel? unit;
  CategoryModel? category;
  String? productCode;
  String? name;
  int? purchasePrice;
  int? sellingPrice;
  int? stockQuantity;
  String? description;
  String? expiryDate;
  String? productImageUrl;
  String? drugClass;
  InventoryModel? lastOpname;
  int? discrepancy;

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
    this.lastOpname,
    this.discrepancy,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        productCode: json['productCode'],
        name: json['name'],
        description: json['description'],
        purchasePrice: json['purchasePrice'],
        sellingPrice: json['sellingPrice'] ?? 0,
        expiryDate: json['expiryDate'],
        stockQuantity: json['stockQuantity'] ?? 0,
        category: json['category'] != null
            ? CategoryModel.fromJson(json['category'])
            : null,
        unit: json['unit'] != null ? UnitModel.fromJson(json['unit']) : null,
        productImageUrl: json['productImageUrl'] ?? '',
        drugClass: json['drugClass'],
        lastOpname: json['lastOpname'] != null
            ? InventoryModel.opnameFromJson(json['lastOpname'])
            : null,
        discrepancy: json['lastOpname']?['discrepancy']);
  }

  Map<String, dynamic> toJson() {
    return {
      'productCode': productCode,
      'name': name,
      'description': description,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'expiryDate': expiryDate != null
          ? DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(
              DateFormat('dd-MM-yyyy').parse(expiryDate!),
            )
          : null,
      'stockQuantity': stockQuantity ?? 0,
      'categoryId': category?.id,
      'unitId': unit?.id,
      'productImageUrl': productImageUrl,
      'drugClass': drugClass
    };
  }

  Color get stockColorInfo {
    if (stockQuantity! == StandartStock.empty.value) {
      return StandartStock.empty.color;
    } else if (stockQuantity! <= StandartStock.low.value) {
      return StandartStock.low.color;
    } else {
      return StandartStock.available.color;
    }
  }

  Color get expiryCategory => DateTime.parse(expiryDate!).expiryColor;
}
