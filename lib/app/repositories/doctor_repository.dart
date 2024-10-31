import 'package:medpia_mobile/app/models/doctor_model.dart';
import 'package:medpia_mobile/app/providers/doctor_provider.dart';

class DoctorRepository {
  final DoctorProvider doctorProvider = DoctorProvider();

  List<DoctorModel> doctors = [];

  Future<List<DoctorModel>> getDoctors() async {
    final response = await doctorProvider.getDoctors();

    if(response.statusCode == 200 || response.statusCode == 201){
      final jsonResponse = response.body;
      final data = jsonResponse['data'];
      return data.map<DoctorModel>((json) => DoctorModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load doctor ${response.statusCode}');
    }
  }

  getDoctor() {}
}