class CustomerModel {
  int? id;
  String? name;
  int? age;
  String? address;

  CustomerModel({this.id, this.name, this.age, this.address});

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        address: json['address']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'address': address,
    };
  }
}
