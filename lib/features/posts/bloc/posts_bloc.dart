import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:request_api/features/posts/models/post_data_ui_model.dart';
import 'package:request_api/features/posts/repos/posts_repo.dart';

part 'posts_event.dart';
part 'posts_state.dart';

// event -> bloc -> state
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
    PostsInitialFetchEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostFetchingLoadingState());
    try {
      List<PostDataUiModel> data = await PostsRepo.fetchPosts();
      emit(PostFetchingSuccessState(posts: data)); // <- get Data
    } catch (e) {
      log(e.toString());
      emit(PostFetchingErrorState());
    }
  }
}
