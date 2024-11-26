import 'package:medpia_mobile/app/models/inventory_item_model.dart';

class InventoryModel {
  int? id;
  String? inventoryDate;
  String? inventoryType;
  String? note;
  List<InventoryItemModel>? items = [];

  InventoryModel({this.id, this.inventoryDate, this.inventoryType, this.note, this.items});

    Map<String, dynamic> stockintoJson() {
    return {
      'items': items!.map((item) => item.toJson()).toList(),
      'inventoryDate': DateTime.now().toUtc().add(const Duration(hours: 7)).toIso8601String(),
      'inventoryType': inventoryType = 'in',
      'note': note,
    };
  }

  factory InventoryModel.inventoryFromJson(Map<String, dynamic> json) {
    return InventoryModel(
      id: json['id'],
      inventoryDate: json['inventoryDate'],
      inventoryType: json['inventoryType'],
      note: json['note'],
      items: json['items'] != null
          ? List<InventoryItemModel>.from(
              json['items'].map((x) => InventoryItemModel.fromJson(x)))
          : [],
    );
  }
}

