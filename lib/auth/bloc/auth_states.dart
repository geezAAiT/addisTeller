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

class LoginErrorState extends AuthState {
  final String message;
  LoginErrorState({this.message});
  @override
  List<Object> get props => [message];
}

class UserRegisterSucessState extends AuthState {}

class RegisterErrorState extends AuthState {
  final String message;
  RegisterErrorState({this.message});
  @override
  List<Object> get props => [message];
}

class UserUpdateSucessState extends AuthState {}

class UserUpdateErrorState extends AuthState {
  final String message;
  UserUpdateErrorState({this.message});
  @override
  List<Object> get props => [message];
}

class UserSelfUpdateSucessState extends AuthState {}

class UserSelfUpdateErrorState extends AuthState {
  final String message;
  UserSelfUpdateErrorState({this.message});
  @override
  List<Object> get props => [message];
}

class UserDeleteSucessState extends AuthState {}

class UserDeleteErrorState extends AuthState {
  final String message;
  UserDeleteErrorState({this.message});
  @override
  List<Object> get props => [message];
}

class UsersLoadSucessState extends AuthState {
  List<Auth> users;
  UsersLoadSucessState([this.users = const []]);
  List<Object> get props => [users];
}

class UsersLoadErrorState extends AuthState {
  final String message;
  UsersLoadErrorState({this.message});
  @override
  List<Object> get props => [message];
}
