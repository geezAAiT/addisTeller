import 'package:addis_teller_app/auth/screens/profile.dart';
import 'package:addis_teller_app/auth/widgets/updateForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth.dart';

class UserList extends StatelessWidget {
  static String routeName = '/usersList';
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UserList"),
        actions: [
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () {
              showModalBottomSheet(
                context: ctx,
                builder: (ctx) => UpdateForm(
                  adminOnly: true,
                  update: false,
                ),
              );
            },
          )
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UsersLoadSucessState) {
            final users = state.users;

            return ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  Auth user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.update),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: ctx,
                                  builder: (ctx) => UpdateForm(
                                    auth: user,
                                    adminOnly: true,
                                    update: true,
                                  ),
                                );
                              }),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context)
                                    .add(UserDelete(auth: user));
                              }),
                        ],
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
        listener: (context, state) {
          if (state is UsersLoadErrorState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('${state.message}')));
          }
        },
      ),
    );
  }
}
