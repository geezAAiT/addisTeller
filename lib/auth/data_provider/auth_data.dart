import 'dart:convert';
import 'package:addis_teller_app/auth/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthDataProvider {
  // final _baseUrl = 'http://192.168.122.1:5050';
  final http.Client httpClient;

  AuthDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Auth> loginUser(Auth auth) async {
    final response = await httpClient.post(
      Uri.http('192.168.1.103:6002', '/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{"email": auth.email, "password": auth.password}),
    );

    if (response.statusCode == 200) {
      debugPrint('${response.body}');
      return Auth.fromJson(jsonDecode(response.body));
    } else
      throw Exception(response.body);
  }
}
