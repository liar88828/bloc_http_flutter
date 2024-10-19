import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_api/features/posts/bloc/posts_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsBloc postsBloc = PostsBloc();
  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Page'),
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        listener: (context, state) => true,
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostFetchingLoadingState:
              return Center(child: CircularProgressIndicator());
            case PostFetchingErrorState:
              return Center(child: Text('Error'));
            case PostFetchingSuccessState:
              final successState = state as PostFetchingSuccessState;

              return Container(
                  child: ListView.builder(
                padding: EdgeInsets.all(2),
                itemCount: successState.posts.length,
                itemBuilder: (context, index) {
                  final post = successState.posts[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.all(10),
                      tileColor: Colors.lightBlue,
                      key: Key(post.id.toString()),
                      title: Text(post.title),
                      subtitle: Text(post.body),
                    ),
                  );
                },
              ));
            default:
              return Text('');
          }
        },
      ),
    );
  }
}
