class UserLoginModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final int? points;
  final int? credit;
  final String? token;

  UserLoginModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "NNONE",
      email: json['email'] ?? "NNONE",
      phone: json['phone'] ?? "NNONE",
      image: json['image'] ?? "NNONE",
      points: json['points'] ?? 0,
      credit: json['credit'] ?? 0,
      token: json['token'] ?? "NNONE",
    );
  }
}
