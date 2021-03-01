import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../post.dart';

class PostList extends StatelessWidget {
  static String routeName = '/postsList';
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PostList"),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostLoadSuccess) {
            final posts = state.posts;

            return ListView.builder(
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  Post post = posts[index];
                  return ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(post.user['name']),
                      subtitle: Text(post.body),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            BlocProvider.of<PostBloc>(context)
                                .add(PostDelete(post: post));
                          }));
                });
          }
          return Container();
        },
        listener: (context, state) {
          if (state is PostOperationFailure) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('${state.message}')));
          }
        },
      ),
    );
  }
}
