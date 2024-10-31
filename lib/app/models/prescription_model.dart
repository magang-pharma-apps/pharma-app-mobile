import 'package:medpia_mobile/app/models/customer_model.dart';
import 'package:medpia_mobile/app/models/doctor_model.dart';
import 'package:medpia_mobile/app/modules/prescription/views/prescription_form.dart';

class PrescriptionModel {
  int? id;
  String? prescriptionCode;
  String? prescriptions;
  String? prescriptionDate;
  DoctorModel? doctor;
  CustomerModel? customer;
  bool? isRedeem;

  PrescriptionModel(
      {this.id,
      this.prescriptionCode,
      this.prescriptions,
      this.prescriptionDate,
      this.doctor,
      this.customer,
      this.isRedeem});

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
        id: json['id'],
        prescriptionCode: json['prescriptionCode'],
        prescriptions: json['prescriptions'],
        prescriptionDate: json['prescriptionDate'],
        doctor: json['doctor'] != null
            ? DoctorModel.fromJson(json['doctor'])
            : null,
        customer: json['customer'] != null
            ? CustomerModel.fromJson(json['customer'])
            : null,
        isRedeem: json['isRedeem']);
  }
}
