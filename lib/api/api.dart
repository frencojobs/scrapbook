import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';

import 'package:scrapbook/models/models.dart';

class Api {
  static final _dio = (Dio()..transformer = FlutterTransformer());
  static var client = RestClient(_dio);
}

class RestClient {
  final baseUrl = 'https://scrapbook.hackclub.com/api';
  final Dio dio;
  RestClient(this.dio);

  static List<Post> _postsFromResponse(List<dynamic> res) {
    return res
        .map((dynamic i) => Post.fromJson(i as Map<String, dynamic>))
        .toList();
  }

  static List<User> _usersFromResponse(List<dynamic> res) {
    return res
        .map((dynamic i) => User.fromJson(i as Map<String, dynamic>))
        .toList();
  }

  static UserInfo _userInfoFromResponse(Map<String, dynamic> res) {
    return UserInfo.fromJson(res);
  }

  Future<List<Post>> fetchPosts() async {
    final result = await dio.request<List<dynamic>>(
      '/posts',
      options: RequestOptions(
        method: 'GET',
        headers: <String, dynamic>{},
        baseUrl: baseUrl,
      ),
    );

    final value = await compute(_postsFromResponse, result.data);

    return Future.value(value);
  }

  Future<List<User>> fetchUsers() async {
    final result = await dio.request<List<dynamic>>(
      '/users',
      options: RequestOptions(
        method: 'GET',
        headers: <String, dynamic>{},
        baseUrl: baseUrl,
      ),
    );

    final value = await compute(_usersFromResponse, result.data);

    return Future.value(value);
  }

  Future<UserInfo> fetchUserByName(String username) async {
    ArgumentError.checkNotNull(username, 'username');

    final result = await dio.request<Map<String, dynamic>>(
      '/users/$username',
      options: RequestOptions(
        method: 'GET',
        headers: <String, dynamic>{},
        baseUrl: baseUrl,
      ),
    );

    final value = await compute(_userInfoFromResponse, result.data);

    return Future.value(value);
  }
}
