import 'package:addis_teller_app/auth/auth.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class FormInitState extends AuthState {}

class LoadingState extends AuthState {}

class UserLoginSucessState extends AuthState {
  final Auth auth;
  UserLoginSucessState({this.auth});
  @override
  List<Object> get props => [auth];
}

class AdminLoginSucessState extends AuthState {
  final Auth auth;
  AdminLoginSucessState({this.auth});
  @override
  List<Object> get props => [auth];
}

class UserRegisterSucessState extends AuthState {}

class UsersLoadSucessState extends AuthState {
  final List<Auth> users;
  UsersLoadSucessState([this.users = const []]);
  List<Object> get props => [users];
}

class LoggedInUserSuccessState extends AuthState {
  final Auth user;
  LoggedInUserSuccessState({this.user});
  List<Object> get props => [user];
  @override
  String toString() => 'Logged In user $user';
}

class AuthFailureState extends AuthState {
  final String message;
  AuthFailureState({this.message});
  @override
  List<Object> get props => [message];
}
