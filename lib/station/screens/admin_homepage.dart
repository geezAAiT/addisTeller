import 'package:addis_teller_app/auth/screens/login.dart';
import 'package:addis_teller_app/station/screens/homepage.dart';
import 'package:addis_teller_app/station/widgets/createAndUpdate.dart';
import 'package:addis_teller_app/station/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomepage extends StatefulWidget {
  static String routeName = '/';
  @override
  _AdminHomepageState createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  Radius borderRadius = Radius.circular(15);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("admin"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear();
              print(
                  "${preferences.getString('id')} and ${preferences.getString('token')}");
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          )
        ],
      ),
      body: Homepage(
        trailing: true,
      ),
      bottomSheet: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              builder: (context) => SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: AddAndUpdateField(edit: false)),
                    ),
                  ));
        },
        child: Icon(Icons.add),
      ),
      drawer: Navigation_Drawer(),
    );
  }
}
