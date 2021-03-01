import 'dart:convert';
import 'dart:io';
import 'package:addis_teller_app/auth/auth.dart';
import 'package:addis_teller_app/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthDataProvider {
  // final _baseUrl = 'http://192.168.122.1:5050';
  final http.Client httpClient;

  AuthDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<String> pref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    return token;
  }

  Future<Auth> loginUser(Auth auth) async {
    final response = await httpClient.post(
      Uri.http('192.168.122.1:5000', '/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{"email": auth.email, "password": auth.password}),
    );

    if (response.statusCode == 200) {
      return Auth.fromJson(jsonDecode(response.body));
    } else
      throw Exception(jsonDecode(response.body)["message"]);
  }

  Future<Auth> registerUser(Auth auth) async {
    final response = await httpClient.post(
      Uri.http('192.168.122.1:5000', '/users/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "email": auth.email,
        "password": auth.password,
        "name": auth.name
      }),
    );

    if (response.statusCode == 201) {
      return Auth.fromJson(jsonDecode(response.body));
    } else
      throw Exception(jsonDecode(response.body)["message"]);
  }

  Future<void> deleteUser(String id) async {
    final token = await pref();
    final response = await httpClient.delete(
      '${Constants.baseUrl}/users/$id',
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    if (response.statusCode != 204) {
      throw Exception('error deleting user');
    }
  }

  Future<void> updateUser(Auth auth) async {
    final token = await pref();
    final http.Response response = await httpClient.put(
      '${Constants.baseUrl}/users/${auth.id}',
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'name': auth.name,
        'email': auth.email,
        'password': auth.password,
        'isAdmin': auth.isAdmin
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user.');
    }
  }

  Future<void> updateSelf(Auth auth) async {
    final token = await pref();
    final http.Response response = await httpClient.put(
      '${Constants.baseUrl}/users/',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'name': auth.name,
        'email': auth.email,
        'password': auth.password,
        'isAdmin': auth.isAdmin
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user.');
    }
  }

  Future<List<Auth>> getUsers() async {
    final token = await pref();
    final http.Response response =
        await httpClient.get('${Constants.baseUrl}/users', headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final users = jsonDecode(response.body) as List;
      // print(posts);
      return users.map((user) => Auth.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
