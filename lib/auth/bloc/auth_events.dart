import 'package:addis_teller_app/auth/auth.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class StartEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends AuthEvent {
  final Auth auth;
  LoginButtonPressed({this.auth});

  @override
  List<Object> get props => [auth];

  @override
  String toString() => 'User $auth loggedIN';
}
