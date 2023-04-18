import 'package:equatable/equatable.dart';
import 'package:http_adapter/http_adapter.dart';

/// {@template authenticationModel}
/// Authentication model
///
/// [Authentication.empty] represents an unauthenticated user.
/// {@endtemplate}
class UserAuthenticationModel extends Equatable {
  final String token;

  const UserAuthenticationModel({required this.token});

  static const empty = UserAuthenticationModel(token: '');

  bool get isEmpty => this == UserAuthenticationModel.empty;

  bool get isNotEmpty => this != UserAuthenticationModel.empty;

  factory UserAuthenticationModel.fromJson(Map json) {
    if (!json.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }

    return UserAuthenticationModel(token: json['accessToken']);
  }

  UserAuthenticationModel toModel() => UserAuthenticationModel(token: token);

  List get props => [token];
}
