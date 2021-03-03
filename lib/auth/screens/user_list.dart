import 'package:addis_teller_app/auth/screens/admin_user_update.dart';
import 'package:addis_teller_app/auth/widgets/updateForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../auth.dart';

class UserList extends StatelessWidget {
  static String routeName = '/usersList';
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(UsersLoad());
    return Scaffold(
        appBar: AppBar(
          title: Text("UserList"),
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
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                      ),
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () => BlocProvider.of<AuthBloc>(context)
                              .add(UserDelete(auth: user)),
                        ),
                        IconSlideAction(
                          caption: 'Update',
                          color: Colors.grey,
                          icon: Icons.delete,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                          value: BlocProvider.of<AuthBloc>(
                                              context),
                                          child: AdminUserUpdate(
                                            userToUpdate: user,
                                          ),
                                        )));
                          },
                        )
                      ],
                    );
                  });
            }
            return Container();
          },
          listener: (context, state) {
            if (state is AuthFailureState) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('${state.message}')));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: UpdateForm(
                  adminOnly: true,
                  update: false,
                  auth: Auth(isAdmin: true),
                  // auth: ,
                ),
              ),
            );
          },
        ));
  }
}
