// Step 2: Repository Class
// Repository ka kaam hota hai internet se data fetch karna aur Model me convert karna.

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post_model.dart';

class PostRepository {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<GetAllPostsModel>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((json) => GetAllPostsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts (Status Code: ${response.statusCode})');
    }
  }
}
