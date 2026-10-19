// Step 2: Repository Class

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post_model.dart';

class PostRepository {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  // 1. GET API: 
  Future<List<GetAllPostsModel>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => GetAllPostsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts (Status Code: ${response.statusCode})');
    }
  }

  // 2. POST API: 
  Future<GetAllPostsModel> createPost({
    required String title,
    required String body,
    int userId = 1,
  }) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': title,
        'body': body,
        'userId': userId,
      }),
    );

    if (response.statusCode == 201) {
      final dynamic data = jsonDecode(response.body);
      return GetAllPostsModel.fromJson(data);
    } else {
      throw Exception('Failed to create post (Status Code: ${response.statusCode})');
    }
  }
}
