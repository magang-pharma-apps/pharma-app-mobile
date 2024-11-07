import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/cart_model.dart';
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
  CartModel? cart;
  bool? isPaid;

  PrescriptionModel(
      {this.id,
      this.prescriptionCode,
      this.prescriptions,
      this.prescriptionDate,
      this.doctor,
      this.customer,
      this.isRedeem,
      this.cart,
      this.isPaid});

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

  Map<String, dynamic> toJson() {
    return {
      'prescriptionId': id,
      'isRedeem': true,
      'price': 10000,
      'isPaid': true,
      'transaction': cart!.toJson(transactionType: 'Prescription')
    };
  }
}
