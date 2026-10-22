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

  // 3. PUT API: Update an existing post on the server
  Future<GetAllPostsModel> updatePost({
    required int id,
    required String title,
    required String body,
    int userId = 1,
  }) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': id,
        'title': title,
        'body': body,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return GetAllPostsModel.fromJson(data);
    } else {
      throw Exception('Failed to update post (Status Code: ${response.statusCode})');
    }
  }

  // 4. DELETE API: Delete
  Future<bool> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete post (Status Code: ${response.statusCode})');
    }
  }
}
