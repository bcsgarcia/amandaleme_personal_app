import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final DateTime birthday;
  final String? phone;
  final bool isActive;
  final String gender;
  final String idCompany;
  final String? photoUrl;
  final String email;

  UserModel({
    this.photoUrl,
    this.phone,
    required this.id,
    required this.name,
    required this.birthday,
    required this.isActive,
    required this.gender,
    required this.idCompany,
    required this.email,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        birthday,
        phone,
        isActive,
        gender,
        idCompany,
        photoUrl,
        email,
      ];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        birthday: DateTime.parse(json['birthday']),
        phone: json['phone'],
        isActive: json['isActive'] == 1,
        gender: json['gender'],
        idCompany: json['idCompany'],
        photoUrl: json['photoUrl'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'birthday': birthday.toIso8601String(),
      'phone': phone,
      'isActive': isActive ? 1 : 0,
      'gender': gender,
      'idCompany': idCompany,
      'photoUrl': photoUrl,
      'email': email,
    };
  }
}
