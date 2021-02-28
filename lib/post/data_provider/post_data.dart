import 'dart:convert';
import 'dart:io';
import 'package:addis_teller_app/constants.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../post.dart';
import 'package:http/http.dart' as http;

class PostDataProvider {
  // final _baseUrl = 'http://192.168.43.187:5000';
  final http.Client httpClient;

  PostDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<String> pref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    return token;
  }

  Future<String> prefUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userID = pref.getString("id");
    return userID;
  }

  Future<Post> createPost(Post post, String stationID) async {
    print(stationID);
    final token = await pref();
    final userID = await prefUser();
    final response = await httpClient.post(
      Uri.http('192.168.122.1:6002', '/posts/$stationID'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'body': post.body,
        'user': userID,
      }),
    );
    print("response ${response.body}");
    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  Future<List<Post>> getPosts() async {
    final token = await pref();
    final response = await httpClient.get(
      '${Constants.baseUrl}/posts',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    // print(response.body);
    if (response.statusCode == 200) {
      final posts = jsonDecode(response.body) as List;
      print(posts);
      return posts.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<Post>> getPostByStationID(String stationID) async {
    print("station id is $stationID");
    final token = await pref();
    final response = await httpClient.get(
      '${Constants.baseUrl}/posts/$stationID',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    // print(response.body);
    if (response.statusCode == 200) {
      final posts = jsonDecode(response.body) as List;
      print(posts);
      return posts.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> deletePost(String id) async {
    final token = await pref();
    final http.Response response = await httpClient.delete(
      '${Constants.baseUrl}/posts/$id',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to delete post.');
    }
  }

  Future<void> updatePost(Post post) async {
    final token = await pref();
    final http.Response response = await httpClient.put(
      '${Constants.baseUrl}/posts/${post.id}',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'body': post.body,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update post.');
    }
  }
}
