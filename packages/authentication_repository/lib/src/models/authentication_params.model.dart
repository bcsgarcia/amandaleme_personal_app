import 'package:equatable/equatable.dart';

class AuthenticationParam extends Equatable {
  final String email;
  final String pass;

  List get props => [email, pass];

  AuthenticationParam({required this.email, required this.pass});
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({required this.email, required this.password});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParam params) =>
      RemoteAuthenticationParams(email: params.email, password: params.pass);

  Map toJson() => {'email': email, 'password': password};
}
