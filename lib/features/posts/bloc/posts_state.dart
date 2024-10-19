// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

abstract class PostsActionState extends PostsState {}

final class PostsInitial extends PostsState {}

class PostFetchingErrorState extends PostsState {}

class PostFetchingLoadingState extends PostsState {}

class PostFetchingSuccessState extends PostsState {
  final List<PostDataUiModel> posts;
  PostFetchingSuccessState({
    required this.posts,
  });
}

class PostsAddSuccessState extends PostsActionState {}

class PostsAddErrorState extends PostsActionState {}

class PostsAddLoadingState extends PostsActionState {}
