class CategoryModel {
  int? id;
  String? name;
  String? description;
  String? categoryImageUrl;

  CategoryModel({this.id, this.name, this.description, this.categoryImageUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      categoryImageUrl: json['categoryImageUrl'] ?? '',
    );
  }
}
