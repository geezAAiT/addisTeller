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

class RegisterButtonPressed extends AuthEvent {
  final Auth auth;
  RegisterButtonPressed({this.auth});

  @override
  List<Object> get props => [auth];

  @override
  String toString() => 'User $auth Registered';
}

class UserSelfUpdate extends AuthEvent {
  final Auth auth;
  UserSelfUpdate({this.auth});
  @override
  List<Object> get props => [auth];
  @override
  String toString() => 'User $auth Self-Updated';
}

class UserUpdate extends AuthEvent {
  final Auth auth;
  UserUpdate({this.auth});
  @override
  List<Object> get props => [auth];
  @override
  String toString() => 'User $auth Updated';
}

class UserDelete extends AuthEvent {
  final Auth auth;
  UserDelete({this.auth});
  @override
  List<Object> get props => [auth];
  @override
  String toString() => 'User $auth Deleted';
}

class UsersLoad extends AuthEvent {
  final List<Auth> auth;
  UsersLoad({this.auth});
  @override
  List<Object> get props => [auth];
  @override
  String toString() => 'Users $auth';
}
