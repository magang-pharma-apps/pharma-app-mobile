import 'dart:convert';

import 'package:medpia_mobile/app/models/unit_model.dart';
import 'package:medpia_mobile/app/providers/unit_provider.dart';

class UnitRepository {
  final UnitProvider unitProvider = UnitProvider();

  List<UnitModel> units = [];

  Future<List<UnitModel>> getUnits() async {
    final response = await unitProvider.getUnits();
    // print(response.body);
    // print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return data.map<UnitModel>((json) => UnitModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load unit ${response.statusCode}');
    }
  }

  Future<bool> createUnit(Map<String, dynamic> body) async {
    try {
      final response = await unitProvider.createUnit(body);
      // print(response.body);
      // print('status ${response.statusCode}');

      if (response.statusCode == 201) {
        return true;
      } else {
        final errorResponse = json.decode(response.body);
        throw Exception('Failed to create unit: ${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to create unit: $e');
    }
  }

  Future<bool> deleteUnit(int id) async {
    try {
      final response = await unitProvider.deleteUnit(id);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final errorResponse = json.decode(response.body);
        throw Exception('Failed to delete unit: ${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to delete unit: $e');
    }
  }
}
