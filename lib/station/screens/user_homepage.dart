import 'package:addis_teller_app/auth/screens/login.dart';
import 'package:addis_teller_app/station/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatelessWidget {
  static String routeName = '/userpage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("user"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          )
        ],
      ),
      body: Homepage(
        trailing: false,
      ),
    );
  }
}
