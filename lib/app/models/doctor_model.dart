class DoctorModel {
  int? id;
  String? name;
  String? specialization;
  String? phoneNumber;
  String? email;

  DoctorModel({this.id, this.name, this.specialization, this.phoneNumber, this.email});

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
        id: json['id'],
        name: json['name'],
        specialization: json['specialization'],
        phoneNumber: json['phoneNumber'],
        email: json['email']);
  }
}
