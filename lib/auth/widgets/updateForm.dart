import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth.dart';

class UpdateForm extends StatefulWidget {
  UpdateForm({this.adminOnly, this.auth, this.update});
  final Auth auth;
  final bool adminOnly, update;
  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> userData = {};

  @override
  Widget build(BuildContext context) {
    bool _checkBoxVal = widget.auth.isAdmin;
    return Center(
      child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                  initialValue: this.widget.update ? this.widget.auth.name : '',
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
                  }),
              TextFormField(
                  initialValue:
                      this.widget.update ? this.widget.auth.email : '',
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
                    if (!this.widget.update &&
                        (value.isEmpty || value.length < 6)) {
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
              this.widget.adminOnly
                  ? Checkbox(
                      value: _checkBoxVal,
                      onChanged: (bool value) {
                        setState(() {
                          _checkBoxVal = value;
                        });
                      })
                  : SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    print("userData=> $userData");
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      final AuthEvent event = !this.widget.adminOnly
                          ? UserSelfUpdate(
                              auth: Auth(
                                  name: userData["name"],
                                  email: userData["email"],
                                  password: userData["password"]),
                            )
                          : UserUpdate(
                              auth: Auth(
                                  name: userData["name"],
                                  email: userData["email"],
                                  password: userData["password"],
                                  isAdmin: _checkBoxVal),
                            );
                      BlocProvider.of<AuthBloc>(context).add(event);
                    }
                  },
                  label: Text("Update"),
                  icon: Icon(Icons.update),
                ),
              ),
            ],
          )),
    );
  }
}
