import 'package:addis_teller_app/auth/bloc/auth_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth.dart';

class UserForm extends StatefulWidget {
  UserForm({this.login});
  final bool login;
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> userData = {};
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              !this.widget.login
                  ? TextFormField(
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'name'),
                      onSaved: (value) {
                        setState(() {
                          userData["name"] = value;
                        });
                      })
                  : SizedBox.shrink(),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty ||
                        value.length < 6 ||
                        !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'email'),
                  onSaved: (value) {
                    setState(() {
                      userData["email"] = value;
                    });
                  }),
              TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 6) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'password'),
                  onSaved: (value) {
                    setState(() {
                      userData["password"] = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    print("userData=> $userData");
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      final AuthEvent event = this.widget.login
                          ? LoginButtonPressed(
                              auth: Auth(
                                  email: userData["email"],
                                  password: userData["password"]),
                            )
                          : RegisterButtonPressed(
                              auth: Auth(
                                  name: userData["name"],
                                  email: userData["email"],
                                  password: userData["password"]),
                            );
                      BlocProvider.of<AuthBloc>(context).add(event);
                    }
                  },
                  label: this.widget.login ? Text("Login") : Text("Register"),
                  icon: this.widget.login
                      ? Icon(Icons.login)
                      : Icon(Icons.app_registration),
                ),
              ),
            ],
          )),
    );
  }
}
