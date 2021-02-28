import 'package:addis_teller_app/auth/auth.dart';
import 'package:addis_teller_app/auth/screens/login.dart';
import 'package:addis_teller_app/auth/widgets/form.dart';
import 'package:addis_teller_app/station/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatelessWidget {
  static String routeName = '/register';
  @override
  Widget build(BuildContext context) {
    final msg = BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is LoginLoadingState)
        return Center(
          child: CircularProgressIndicator(),
        );
      else
        return Container();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserRegisterSucessState)
            Navigator.pushNamedAndRemoveUntil(
                context, Login.routeName, (route) => false);
          if (state is RegisterErrorState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('${state.message}')));
          }
        },
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 24),
            children: [
              UserForm(
                login: false,
              ),
              msg,
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Login.routeName);
                  },
                  child: Text('Already have an account? Login'))
            ],
          ),
        ),
      ),
    );
  }
}
