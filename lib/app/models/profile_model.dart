class ProfileModel {
  String? username;
  String? email;
  String? role;

  ProfileModel({this.username, this.email, this.role});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json['username'],
      email: json['email'],
      role: json['role'],
    );
  }
}
