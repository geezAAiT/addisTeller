import 'package:addis_teller_app/auth/auth.dart';
import 'package:addis_teller_app/auth/screens/profile.dart';
import 'package:addis_teller_app/auth/screens/user_list.dart';
import 'package:addis_teller_app/post/bloc/post_bloc.dart';
import 'package:addis_teller_app/post/bloc/post_event.dart';
import 'package:addis_teller_app/post/screens/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is LoggedInUserSuccessState) {
          final user = state.user;
          print("navigation : $user");
          return ListView(
            children: [
              DrawerHeader(
                name: user.name,
                email: user.email,
              ),
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  Navigator.pushNamed(context, Profile.routeName);
                },
              ),
              user.isAdmin
                  ? ListTile(
                      title: Text('Users'),
                      onTap: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(LoggedInUser(id: user.id));

                        Navigator.pushNamed(context, UserList.routeName);
                      },
                    )
                  : SizedBox.shrink(),
              user.isAdmin
                  ? ListTile(
                      title: Text('Posts'),
                      onTap: () {
                        BlocProvider.of<PostBloc>(context).add(PostLoad());
                        Navigator.pushNamed(context, PostList.routeName);
                      },
                    )
                  : SizedBox.shrink(),
            ],
          );
        }
        return Container();
      }),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  DrawerHeader({this.name, this.email});
  final String name, email;
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(name),
      accountEmail: Text(email),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: FlutterLogo(
          size: 42.0,
        ),
      ),
    );
  }
}
