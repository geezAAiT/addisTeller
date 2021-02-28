import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Post extends Equatable {
  Post({
    this.id,
    this.user,
    @required this.body,
  });
  final String id, body;
  Map<String, dynamic> user;

  @override
  List<Object> get props => [id, body, user];

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(id: json['_id'], body: json['body'], user: json['user']);
  }

  @override
  String toString() => 'Post { id:$id, body:$body, user: $user }';
}
