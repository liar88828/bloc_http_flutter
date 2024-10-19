import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:request_api/features/posts/models/post_data_ui_model.dart';

import 'package:http/http.dart' as http;

class PostsRepo {
  static List<PostDataUiModel> stores = [];
  static Future<List<PostDataUiModel>> fetchPosts() async {
    try {
      final client = http.Client();
      final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      final response = await client.get(url);

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<PostDataUiModel> data =
            body.map((dynamic item) => PostDataUiModel.fromMap(item)).toList();

        stores = data;
        return stores;
      } else {
        throw Exception('Error');
      }
      // if (response.statusCode == 200) {
      // print('is true');

      // }
    } on Exception catch (_) {
      // reThrow e.toString();
      rethrow;
    }
  }

  static Future<bool> addPosts() async {
    try {
      final client = http.Client();
      final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      PostDataUiModel postData = PostDataUiModel(
        userId: 1,
        id: stores.length + 1,
        title: 'Sample Title test',
        body: 'Sample Body test',
      );
      var stringData = postData.sendData();
      final response = await client.post(url, body: stringData);
      if (response.statusCode == 201) {
        var body = jsonDecode(response.body);
        // print(body);
        // print(stores.length);
        stores.add(postData);
        print('success');
        return true;
      } else {
        return false;
        // throw Exception('Error');
      }
      // if (response.statusCode == 200) {
      // print('is true');

      // }
    } on Exception catch (e) {
      // reThrow e.toString();
      // return false;
      print(e);
      rethrow;
    }
  }
}
