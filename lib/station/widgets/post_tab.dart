import 'package:addis_teller_app/post/post.dart';
import 'package:addis_teller_app/post/screens/widgets/post_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../station.dart';

class PostTab extends StatefulWidget {
  PostTab({this.station, this.userID, this.isAdmin});
  final Station station;
  final String userID;
  final bool isAdmin;
  @override
  _PostTabState createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          PostForm(
            update: false,
            station: this.widget.station,
          ),
          BlocConsumer<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is StationPostsLoadSuccess) {
                final posts = state.stationPosts;
                return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: posts.length,
                  itemBuilder: (context, index) => Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.picture_in_picture_outlined),
                      ),
                      title: Text("${posts[index].user["name"]}"),
                      subtitle: Text("${posts[index].body}"),
                    ),
                    secondaryActions: [
                      posts[index].user["_id"] == this.widget.userID ||
                              this.widget.isAdmin
                          ? IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () => BlocProvider.of<PostBloc>(context)
                                  .add(StationPostDelete(
                                      post: posts[index],
                                      stationID: this.widget.station.id)),
                            )
                          : SizedBox.shrink(),
                      posts[index].user["_id"] == this.widget.userID
                          ? IconSlideAction(
                              caption: 'Update',
                              color: Colors.grey,
                              icon: Icons.update,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: Text("Update Post"),
                                          content: PostForm(
                                              update: true,
                                              station: this.widget.station,
                                              post: posts[index]),
                                          actions: [
                                            FlatButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text('cancel')),
                                          ],
                                        ));
                              },
                            )
                          : SizedBox.shrink()
                    ],
                  ),
                );
              }
              return Container();
            },
            listener: (context, state) {
              if (state is PostOperationFailure) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("${state.message}")));
              }
            },
          ),
        ],
      ),
    );
  }
}
