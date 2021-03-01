import 'package:addis_teller_app/station/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../post.dart';

class PostForm extends StatefulWidget {
  PostForm({this.station, this.update, this.post});
  final Station station;
  final bool update;
  final Post post;
  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> post = {};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
              initialValue: this.widget.update ? this.widget.post.body : '',
              autofocus: false,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Write station\'s status';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'body'),
              onSaved: (value) {
                setState(() {
                  post["body"] = value;
                });
              }),
          ElevatedButton.icon(
            onPressed: () {
              final form = _formKey.currentState;
              if (form.validate()) {
                form.save();
                final PostEvent event = !this.widget.update
                    ? PostCreate(
                        Post(
                          body: post["body"],
                        ),
                        this.widget.station.id)
                    : PostUpdate(
                        Post(body: post["body"], id: this.widget.post.id),
                        this.widget.station.id);

                BlocProvider.of<PostBloc>(context).add(event);
                if (event is PostUpdate) {
                  Navigator.pop(context);
                }
              }
            },
            label: !this.widget.update
                ? Text('post status')
                : Text('update status'),
            icon: Icon(Icons.post_add),
          ),
        ],
      ),
    );
  }
}
