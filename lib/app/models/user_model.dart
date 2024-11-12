class UserModel {
  String? id;
  String? username;
  String? email;
  String? role;

  UserModel({this.id, this.username, this.email, this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        username: json['username'] ?? '',
        email: json['email'],
        role: json['role']);
  }
}
