import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/commons/enums/expiry_standard.dart';
import 'package:medpia_mobile/app/commons/enums/stock_standard.dart';
import 'package:medpia_mobile/app/models/product_model.dart';

class InventoryItemModel {
  ProductModel? product;
  int? quantity;
  int? physicalStock;
  int? discrepancy;
  String? note;

  InventoryItemModel(
      {this.product,
      this.quantity,
      this.note,
      this.physicalStock,
      this.discrepancy = 0});

  factory InventoryItemModel.fromJson(Map<String, dynamic> json) {
    return InventoryItemModel(
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
      note: json['noteItem'] ?? '',
      quantity: json['qtyItem'],
    );
  }

  factory InventoryItemModel.fromJsonOpname(Map<String, dynamic> json) {
    return InventoryItemModel(
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
      physicalStock: json['physicalStock'] ?? 0,
      discrepancy: json['discrepancy'] ?? 0,
    );
  }

  InventoryItemModel copyWith({
    ProductModel? product,
    int? quantity,
    int? physicalStock,
    int? discrepancy,
    String? note,
  }) {
    return InventoryItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      physicalStock: physicalStock ?? this.physicalStock,
      discrepancy: discrepancy ?? this.discrepancy,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': product!.id,
      'qtyItem': quantity,
      'noteItem': note,
    };
  }

  Map<String, dynamic> toJsonOpname() {
    return {
      'productId': product!.id,
      // 'note': note,
      'physicalStock': physicalStock,
      'discrepancy': discrepancy,
    };
  }

  Color get stockColorInfo {
    if (product!.stockQuantity == StandartStock.empty.value) {
      return StandartStock.empty.color;
    } else if (product!.stockQuantity! <= StandartStock.low.value) {
      return StandartStock.low.color;
    } else {
      return StandartStock.available.color;
    }
  }

  Color get expiryCategory => DateTime.parse(product!.expiryDate!).expiryColor;
}
