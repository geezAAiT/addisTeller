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
            if (state is LoggedInUserSuccessState) {
              final auth = state.user;
              return auth.isAdmin
                  ? UpdateForm(
                      auth: auth,
                      update: true,
                      adminOnly: true,
                    )
                  : UpdateForm(
                      auth: auth,
                      update: true,
                      adminOnly: false,
                    );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
