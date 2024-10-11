class ProductModel {
  int? id;
  int? unitId;
  int? categoryId;
  String? code;
  String? name;
  int? purchasePrice;
  int? sellingPrice;
  int? quantity;
  String? description;
  String? expiryDate;
  bool? status;
  String? image;

  ProductModel(
      {this.id,
      this.unitId,
      this.categoryId,
      this.code,
      this.name,
      this.purchasePrice,
      this.sellingPrice,
      this.quantity,
      this.description,
      this.expiryDate,
      this.status,
      this.image});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        unitId: json['unit_id'],
        categoryId: json['category_id'],
        code: json['code'],
        name: json['name'],
        purchasePrice: json['purchase_price'],
        sellingPrice: json['selling_price'],
        quantity: json['quantity'],
        description: json['description'],
        expiryDate: json['expiry_date'],
        status: json['status'],
        image: json['image_assets']);
  }
}

class ProductRepository {
  List<Map<String, dynamic>> getProduct() {
    return [
      {
        "id": 1,
        "unitId": 2,
        "categoryId": 1,
        "code": "DRG001",
        "name": "Paracetamol",
        "purchase_price": 5000,
        "selling_price": 6500,
        "quantity": 100,
        "description": "Pereda nyeri",
        "expiry_date": "2025-12-31",
        "status": true,
        "image_assets": "assets/images/paracet.jpg"
      },
      {
        "id": 2,
        "unitId": 3,
        "categoryId": 1,
        "code": "DRG002",
        "name": "Amoxicillin",
        "purchase_price": 10000,
        "selling_price": 12500,
        "quantity": 50,
        "description": "Antibiotik",
        "expiry_date": "2024-11-30",
        "status": true,
        "image_assets": "assets/images/paracet.jpg"
      },
      {
        "id": 3,
        "unitId": 2,
        "categoryId": 2,
        "code": "DRG003",
        "name": "Vitamin C 500mg",
        "purchase_price": 3000,
        "selling_price": 4000,
        "quantity": 200,
        "description": "Meningkatkan daya tahan tubuh",
        "expiry_date": "2026-01-31",
        "status": true,
        "image_assets": "assets/images/paracet.jpg"
      },
      {
        "id": 4,
        "unitId": 2,
        "categoryId": 1,
        "code": "DRG004",
        "name": "Ibuprofen",
        "purchase_price": 7000,
        "selling_price": 9000,
        "quantity": 80,
        "description": "Pereda nyeri, anti-inflamasi",
        "expiry_date": "2025-08-15",
        "status": true,
        "image_assets": "assets/images/paracet.jpg"
      },
      {
        "id": 5,
        "unitId": 2,
        "categoryId": 3,
        "code": "DRG005",
        "name": "Cetirizine",
        "purchase_price": 4000,
        "selling_price": 5500,
        "quantity": 120,
        "description": "Pereda alergi",
        "expiry_date": "2024-12-10",
        "status": true,
        "image_assets": "assets/images/paracet.jpg"
      },
      {
        "id": 6,
        "unitId": 3,
        "categoryId": 1,
        "code": "DRG006",
        "name": "Aspirin 100mg",
        "purchase_price": 6000,
        "selling_price": 7500,
        "quantity": 75,
        "description": "Pereda nyeri, pengencer darah",
        "expiry_date": "2025-10-01",
        "status": true,
        "image_assets": "assets/images/paracet.jpg"
      },
      {
        "id": 7,
        "unitId": 1,
        "categoryId": 4,
        "code": "DRG007",
        "name": "Omeprazole 20mg",
        "purchase_price": 8000,
        "selling_price": 9500,
        "quantity": 60,
        "description": "Pengurang asam lambung",
        "expiry_date": "2026-03-20",
        "status": true,
        "image_assets": "assets/images/paracet.jpg"
      },
      {
        "id": 8,
        "unitId": 2,
        "categoryId": 2,
        "code": "DRG008",
        "name": "Multivitamin",
        "purchase_price": 5000,
        "selling_price": 6500,
        "quantity": 150,
        "description": "Dukungan kesehatan umum",
        "expiry_date": "2026-05-01",
        "status": true,
        "image_assets": "assets/images/paracet.jpg"
      },
      {
        "id": 9,
        "unitId": 3,
        "categoryId": 1,
        "code": "DRG009",
        "name": "Diclofenac Sodium",
        "purchase_price": 9500,
        "selling_price": 11500,
        "quantity": 90,
        "description": "Pereda nyeri, anti-inflamasi",
        "expiry_date": "2025-06-30",
        "status": true,
        "image_assets": "assets/images/paracet.jpg"
      },
      {
        "id": 10,
        "unitId": 2,
        "categoryId": 1,
        "code": "DRG010",
        "name": "Loperamide 2mg",
        "purchase_price": 3500,
        "selling_price": 4500,
        "quantity": 110,
        "description": "Pereda diare",
        "expiry_date": "2025-07-25",
        "status": true,
        "image_assets": "assets/images/paracet.jpg"
      }
    ];
  }
}
