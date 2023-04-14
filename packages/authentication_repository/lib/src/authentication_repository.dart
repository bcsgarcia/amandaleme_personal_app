import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final DateTime birthday;
  final String? phone;
  final bool isActive;
  final DateTime lastUpdate;
  final DateTime? signDate;
  final String gender;
  final String idCompany;
  final String? photoUrl;
  final String idAuth;

  User({
    required this.id,
    required this.name,
    required this.birthday,
    this.phone,
    required this.isActive,
    required this.lastUpdate,
    this.signDate,
    required this.gender,
    required this.idCompany,
    this.photoUrl,
    required this.idAuth,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        birthday,
        phone,
        isActive,
        lastUpdate,
        signDate,
        gender,
        idCompany,
        photoUrl,
        idAuth,
      ];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      birthday: DateTime.parse(json['birthday']),
      phone: json['phone'],
      isActive: json['isActive'] == 1,
      lastUpdate: DateTime.parse(json['lastUpdate']),
      signDate:
          json['signDate'] != null ? DateTime.parse(json['signDate']) : null,
      gender: json['gender'],
      idCompany: json['idCompany'],
      photoUrl: json['photoUrl'],
      idAuth: json['idAuth'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'birthday': birthday.toIso8601String(),
      'phone': phone,
      'isActive': isActive ? 1 : 0,
      'lastUpdate': lastUpdate.toIso8601String(),
      'signDate': signDate?.toIso8601String(),
      'gender': gender,
      'idCompany': idCompany,
      'photoUrl': photoUrl,
      'idAuth': idAuth,
    };
  }
}
