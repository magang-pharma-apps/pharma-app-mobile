import 'package:medpia_mobile/app/commons/utils/format_rupiah.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/cart_model.dart';
import 'package:medpia_mobile/app/models/customer_model.dart';
import 'package:medpia_mobile/app/models/doctor_model.dart';
import 'package:medpia_mobile/app/modules/prescription/views/prescription_form.dart';

class PrescriptionModel {
  int? id;
  String? transactionDate;
  String? prescriptionCode;
  String? prescriptions;
  String? prescriptionDate;
  DoctorModel? doctor;
  CustomerModel? customer;
  bool? isRedeem;
  CartModel? cart;
  bool? isPaid;

  PrescriptionModel({
    this.id,
    this.transactionDate,
    this.prescriptionCode,
    this.prescriptions,
    this.prescriptionDate,
    this.doctor,
    this.customer,
    this.isRedeem,
    this.cart,
    this.isPaid,
  });

  factory PrescriptionModel.prescriptionFromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      id: json['id'],
      prescriptionCode: json['prescriptionCode'],
      prescriptions: json['prescriptions'],
      prescriptionDate: json['prescriptionDate'],
      doctor:
          json['doctor'] != null ? DoctorModel.fromJson(json['doctor']) : null,
      customer: json['customer'] != null
          ? CustomerModel.fromJson(json['customer'])
          : null,
      isRedeem: json['isRedeem'] ?? false,
    );
  }

  factory PrescriptionModel.redemptionFromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      // id: json['prescription']['id'],
      isPaid: json['isPaid'],
      prescriptionCode: json['prescription']['prescriptionCode'],
      transactionDate: json['transaction'] == null
          ? DateTime(0, 0, 0, 0, 0, 0, 0).toString()
          : json['transaction']['transactionDate'],
      customer: json['prescription']['customer'] != null
          ? CustomerModel.fromJson(json['prescription']['customer'])
          : null,
      doctor: json['prescription']['doctor'] != null
          ? DoctorModel.fromJson(json['prescription']['doctor'])
          : null,
      cart: json['transaction'] != null
          ? CartModel.transactionFromJson(json['transaction'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prescriptionId': id,
      'isRedeem': true,
      'isPaid': true,
      'transaction': cart!.toJson(transactionType: 'Prescription'),
    };
  }

  List<CartItemModel> get cartItems => cart!.items!;

  String get patient => customer!.name!;

  String get doctorName => doctor!.name!;

  bool get isCartNotNull => cart != null;

  String get subtotalFormatted =>
      FormatRupiah.format(cart?.subtotal!.toInt() ?? 0);

  String get grandtotalFormatted =>
      FormatRupiah.format(cart?.grandtotal!.toInt() ?? 0);

  String get taxFormatted => FormatRupiah.format(cart?.tax!.toInt() ?? 0);
}
