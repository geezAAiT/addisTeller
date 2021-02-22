import 'package:addis_teller_app/auth/auth.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class LoginInitState extends AuthState {}

class LoginLoadingState extends AuthState {}

class UserLoginSucessState extends AuthState {}

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
