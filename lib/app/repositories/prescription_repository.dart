import 'dart:convert';

import 'package:http/http.dart';
import 'package:medpia_mobile/app/models/prescription_model.dart';
import 'package:medpia_mobile/app/providers/prescription_provider.dart';

class PrescriptionRepository {
  PrescriptionProvider prescriptionProvider = PrescriptionProvider();

  List<PrescriptionModel> prescriptions = [];

  Future<List<PrescriptionModel>> getPrescriptions() async {
    final response = await prescriptionProvider.getPrescriptions();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return data
          .map<PrescriptionModel>((json) => PrescriptionModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load prescription ${response.statusCode}');
    }
  }


  getPrescription() {}
}
