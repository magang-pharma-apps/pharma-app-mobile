class UnitModel {
  int? id;
  String? name;
  String? description;

  UnitModel({id, name, description});

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'],
      name: json['name'],
      description: json['description']
    );
  }
}
