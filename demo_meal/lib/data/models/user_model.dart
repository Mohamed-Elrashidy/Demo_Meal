import '../../domain/entity/user.dart';

class UserModel extends User {
  UserModel(
      {required super.name,
      required super.phone,
      required super.email,
      required super.address,
      required super.level});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        email:json['email'],
        level: int.parse(json['level']),
        address: json['address'],
        phone:json['phone']
    );}
}
