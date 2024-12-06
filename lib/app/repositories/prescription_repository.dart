import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:medpia_mobile/app/models/prescription_model.dart';
import 'package:medpia_mobile/app/providers/prescription_provider.dart';

class PrescriptionRepository {
  PrescriptionProvider prescriptionProvider = PrescriptionProvider();

  List<PrescriptionModel> prescriptions = [];

  Future<List<PrescriptionModel>> getPrescriptions() async {
    final response = await prescriptionProvider.getPrescriptions();
    // print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return data
          .map<PrescriptionModel>(
              (json) => PrescriptionModel.prescriptionFromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load prescription ${response.statusCode}');
    }
  }

  Future<void> createPrescription(Map<String, dynamic> body) async {
    try {
      final response = await prescriptionProvider.createPrescriptions((body));
      // print(response.body);
      // print('status ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        final errorResponse = json.decode(response.body);
        throw Exception(
            'Failed to create prescription: ${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to create prescription: $e');
    }
  }

  Future<List<PrescriptionModel>> getRedemptions() async {
    final response = await prescriptionProvider.getRedemptions();
    // print(response.body);
    // print('status ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return data
          .map<PrescriptionModel>(
              (json) => PrescriptionModel.redemptionFromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load redemptions ${response.statusCode}');
    }
  }

  Future<bool> createRedemption(Map<String, dynamic> body) async {
    try {
      final response = await prescriptionProvider.createRedemption(body);
      // print(response.body);
      // print('status ${response.statusCode}');

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to create redemption: $e');
    }
  }
}
