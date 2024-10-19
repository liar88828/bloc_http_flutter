import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

// event -> bloc -> state
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    var client = http.Client();
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    try {
      var response = await client.get(url);
      print(response.body);
    } catch (e) {
      log(e.toString());
    }
    // emit(PostsInitial());
  }
}
