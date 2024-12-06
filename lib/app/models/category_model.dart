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
      id: json['id'] ?? 0,
      name: json['name'],
      description: json['description'] ?? '',
      categoryImageUrl: json['categoryImageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'categoryImageUrl': categoryImageUrl,
    };
  }
}
