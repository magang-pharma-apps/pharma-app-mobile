class UnitModel {
  int? id;
  String? name;
  String? description;

  UnitModel({this.id, this.name, this.description});

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
