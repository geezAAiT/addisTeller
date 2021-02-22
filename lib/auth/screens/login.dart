import 'package:addis_teller_app/auth/auth.dart';
import 'package:addis_teller_app/station/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  static String routeName = '/login';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    final msg = BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is LoginErrorState)
        return Text(state.message);
      else if (state is LoginLoadingState)
        return Center(
          child: CircularProgressIndicator(),
        );
      else
        return Container();
    });

    final email = TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        filled: true,
        fillColor: Color(0xFFF2F3F5),
        hintStyle: TextStyle(
          color: Color(0xFF666666),
        ),
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
    final password = TextField(
      controller: passwordController,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        filled: true,
        fillColor: Color(0xFFF2F3F5),
        hintStyle: TextStyle(
          color: Color(0xFF666666),
        ),
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        onPressed: () {
          debugPrint('${passwordController.text}, ${emailController.text}');
          authBloc.add(LoginButtonPressed(
              auth: Auth(
                  email: emailController.text,
                  password: passwordController.text)));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserLoginSucessState)
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => UserPage()),
                (route) => false);
          if (state is AdminLoginSucessState)
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
                (route) => false);
        },
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 24),
            children: [
              msg,
              SizedBox(height: 40),
              email,
              SizedBox(height: 20),
              password,
              SizedBox(height: 24),
              loginButton
            ],
          ),
        ),
      ),
    );
  }
}
