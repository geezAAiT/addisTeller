import 'package:addis_teller_app/auth/auth.dart';
import 'package:addis_teller_app/auth/screens/profile.dart';
import 'package:addis_teller_app/auth/screens/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Navigation_Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AdminLoginSucessState) {
          final user = state.auth;
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
              ListTile(
                title: Text('Users'),
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(UsersLoad());
                  Navigator.pushNamed(context, UserList.routeName);
                },
              ),
              ListTile(
                title: Text('Posts'),
              ),
            ],
          );
        }
        if (state is UserLoginSucessState) {
          final user = state.auth;
          return ListView(
            children: [
              DrawerHeader(
                name: user.name,
                email: user.email,
              ),
              ListTile(
                title: Text('Profile'),
              ),
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
