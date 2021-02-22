import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Auth extends Equatable {
  Auth(
      {this.id,
      this.email,
      this.password,
      this.token,
      this.name,
      this.isAdmin});

  final String id, email, password, token, name;
  final bool isAdmin;

  @override
  List<Object> get props => [id, email, password, token, name, isAdmin];

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        token: json['token'],
        isAdmin: json['isAdmin']);
  }

  @override
  String toString() => 'Auth { id: $id, email: $email, password: $password}';
}
