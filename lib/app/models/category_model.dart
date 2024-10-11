class CategoryModel {
  int? id;
  String? name;
  String? description;
  bool? status;
  String? image;

  CategoryModel({this.id, this.name, this.description, this.status, this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      image: json['image_assets']
    );
  }
}

class CategoryRepository {
  List<Map<String, dynamic>> getCategory() {
    return [
      {
        "id": 1,
        "name": "Analgesics",
        "description": "Medications used to relieve pain.",
        "status": true,
        "image_assets": "assets/images/analgesics.png"
      },
      {
        "id": 2,
        "name": "Antibiotics",
        "description": "Medications used to treat bacterial infections.",
        "status": true,
        "image_assets": "assets/images/antibiotics.png"
      },
      {
        "id": 3,
        "name": "Antihistamines",
        "description": "Medications that relieve or prevent allergy symptoms.",
        "status": true,
        "image_assets": "assets/images/antihistamines.png"
      },
      {
        "id": 4,
        "name": "Antidepressants",
        "description":
            "Medications used to treat depression and anxiety disorders.",
        "status": true,
        "image_assets": "assets/images/antidepressants.png"
      },
      {
        "id": 5,
        "name": "Pediatrics",
        "description": "Medications used to neutralize stomach acid.",
        "status": true,
        "image_assets": "assets/images/medicine_pedi.png"
      }
    ];
  }
}
