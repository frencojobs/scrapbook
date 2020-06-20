import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:scrapbook/models/models.dart';

part 'api.g.dart';

class Api {
  static final _dio = Dio();
  static var client = RestClient(_dio);
}

@RestApi(baseUrl: 'https://scrapbook.hackclub.com/api')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/posts')
  Future<List<Post>> fetchPosts();

  @GET('/users')
  Future<List<User>> fetchUsers();

  @GET('/users/{username}')
  Future<dynamic> fetchUserByName(@Path('username') String username);
}
