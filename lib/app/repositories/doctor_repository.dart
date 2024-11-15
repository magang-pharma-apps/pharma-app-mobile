import 'dart:convert';

import 'package:get/get.dart';
import 'package:medpia_mobile/app/models/doctor_model.dart';
import 'package:medpia_mobile/app/providers/doctor_provider.dart';

class DoctorRepository {
  final DoctorProvider doctorProvider = DoctorProvider();

  List<DoctorModel> doctors = [];

  Future<List<DoctorModel>> getDoctors() async {
    final response = await doctorProvider.getDoctors();

    // print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return data
          .map<DoctorModel>((json) => DoctorModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load doctor ${response.statusCode}');
    }
  }

  Future<bool> createDoctor(Map<String, dynamic> body) async {
    try {
      final response = await doctorProvider.createDoctor(body);

      if (response.statusCode == 201) {
        return true;
        
      }else{
        final errorReponse = json.decode(response.body);
        throw Exception('Failed to create doctor: ${errorReponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to create doctor $e');
    }
  }

  Future<bool> deleteDoctor(int id) async {
    try {
      final response = await doctorProvider.deleteDoctor(id);

      if (response.statusCode == 200) {
        return true;
      } else {
        final errorReponse = json.decode(response.body);
        throw Exception('Failed to delete doctor: ${errorReponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to delete doctor $e');
    }
  }  
}
