import 'dart:convert';

import 'package:request_api/features/posts/models/post_data_ui_model.dart';

import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    try {
      final client = http.Client();
      final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      final response = await client.get(url);
      switch (response.statusCode) {
        case 200:
          List<dynamic> body = jsonDecode(response.body);
          List<PostDataUiModel> data = body
              .map((dynamic item) => PostDataUiModel.fromMap(item))
              .toList();
          return data;
        default:
          throw Exception('Error');
      }
      // if (response.statusCode == 200) {
      // print('is true');

      // }
    } on Exception catch (e) {
      // reThrow e.toString();
      rethrow;
    }
  }
}
