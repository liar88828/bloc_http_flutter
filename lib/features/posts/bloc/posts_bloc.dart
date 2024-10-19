import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:request_api/features/posts/models/post_data_ui_model.dart';

part 'posts_event.dart';
part 'posts_state.dart';

// event -> bloc -> state
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostFetchingLoadingState());

    var client = http.Client();
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        // print('is true');
        List<dynamic> body = jsonDecode(response.body);
        List<PostDataUiModel> data =
            body.map((dynamic item) => PostDataUiModel.fromMap(item)).toList();
        emit(PostFetchingSuccessState(posts: data)); // <- get Data
        return;
      }
    } catch (e) {
      log(e.toString());
      emit(PostFetchingErrorState());
    }
  }
}
