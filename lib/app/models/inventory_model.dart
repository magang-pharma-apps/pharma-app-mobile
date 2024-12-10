import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/models/inventory_item_model.dart';

class InventoryModel {
  int? id;
  String? inventoryDate;
  String? opnameDate;
  String? inventoryType;
  String? reasonType;
  String? note;
  List<InventoryItemModel>? items = [];

  InventoryModel(
      {this.id,
      this.inventoryDate,
      this.opnameDate,
      this.reasonType,
      this.inventoryType,
      this.note,
      this.items});

  Map<String, dynamic> stockinToJson() {
    return {
      'items': items!.map((item) => item.toJson()).toList(),
      'inventoryDate': DateTime.now()
          .toUtc()
          .add(const Duration(hours: 7))
          .toIso8601String(),
      'inventoryType': inventoryType = 'In',
      'reasonType': reasonType,
      'note': note,
    };
  }

  Map<String, dynamic> stockoutToJson() {
    return {
      'items': items!.map((item) => item.toJson()).toList(),
      'inventoryDate': DateTime.now()
          .toUtc()
          .add(const Duration(hours: 7))
          .toIso8601String(),
      'inventoryType': inventoryType = 'Out',
      'reasonType': reasonType,
      'note': note,
    };
  }

  Map<String, dynamic> opnameToJson() {
    return {
      'items': items!.map((item) => item.toJsonOpname()).toList(),
      'opnameDate': opnameDate,
      'note': note,
    };
  }

  factory InventoryModel.inventoryFromJson(Map<String, dynamic> json) {
    // print('json ====> $json');
    return InventoryModel(
      inventoryDate: json['inventoryDate'] ?? '',
      inventoryType: json['inventoryType'] ?? 'In',
      reasonType: json['reasonType'] ?? '',
      note: json['note'] ?? '',
      items: json['items'] is List
          ? List<InventoryItemModel>.from(
              json['items'].map((x) => InventoryItemModel.fromJson(x)))
          : [],
    );
  }

  factory InventoryModel.opnameFromJson(Map<String, dynamic> json) {
    return InventoryModel(
      opnameDate: json['opnameDate'] ?? '',
      note: json['note'] ?? '',
      items: json['items'] is List
          ? List<InventoryItemModel>.from(
              json['items'].map((x) => InventoryItemModel.fromJsonOpname(x)))
          : [],
    );
  }

  String get createdDateFormat {
    DateTime parsedDate = DateTime.parse(inventoryDate!);
    String formattedInventoryDate =
        DateFormat('MM/dd/yyyy hh:mm a').format(parsedDate);
    return formattedInventoryDate;
  }
}
