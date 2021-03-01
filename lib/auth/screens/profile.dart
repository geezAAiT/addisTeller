import 'package:addis_teller_app/auth/widgets/updateForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth.dart';

class Profile extends StatelessWidget {
  static String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AdminLoginSucessState) {
              final auth = state.auth;
              return UpdateForm(
                auth: auth,
                update: true,
                adminOnly: false,
              );
            }
            if (state is UserLoginSucessState) {
              final auth = state.auth;
              return UpdateForm(
                auth: auth,
                update: true,
                adminOnly: false,
              );
            }
          },
        ),
      ),
    );
  }
}
