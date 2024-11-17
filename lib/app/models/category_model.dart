class CategoryModel {
  int? id;
  String? name;
  String? description;
  String? categoryImageUrl;

  CategoryModel({this.id, this.name, this.description, this.categoryImageUrl});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      categoryImageUrl: json['categoryImageUrl'] ?? '',
    );
  }
}
