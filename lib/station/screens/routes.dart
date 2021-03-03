import 'package:addis_teller_app/auth/auth.dart';
import 'package:addis_teller_app/auth/screens/login.dart';
import 'package:addis_teller_app/auth/screens/profile.dart';
import 'package:addis_teller_app/auth/screens/register.dart';
import 'package:addis_teller_app/auth/screens/user_list.dart';
import 'package:addis_teller_app/post/screens/post_list.dart';
import 'package:addis_teller_app/station/screens/admin_homepage.dart';
import 'package:addis_teller_app/station/screens/homepage.dart';
import 'package:addis_teller_app/station/screens/station_detail.dart';
import 'package:addis_teller_app/station/screens/user_homepage.dart';
import 'package:addis_teller_app/station/station.dart';
import 'package:flutter/material.dart';

class StationAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == AdminHomepage.routeName) {
      return MaterialPageRoute(builder: (context) => AdminHomepage());
    }
    if (settings.name == Login.routeName) {
      return MaterialPageRoute(builder: (context) => Login());
    }
    if (settings.name == UserPage.routeName) {
      return MaterialPageRoute(builder: (context) => UserPage());
    }

    if (settings.name == Register.routeName) {
      return MaterialPageRoute(builder: (context) => Register());
    }
    if (settings.name == Profile.routeName) {
      return MaterialPageRoute(builder: (context) => Profile());
    }
    if (settings.name == UserList.routeName) {
      return MaterialPageRoute(builder: (context) => UserList());
    }
    if (settings.name == PostList.routeName) {
      return MaterialPageRoute(builder: (context) => PostList());
    }

    if (settings.name == StationDetail.routeName) {
      Station station = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => StationDetail(
                station: station,
              ));
    }

    return MaterialPageRoute(builder: (context) => Homepage());
  }
}

class StationArgument {
  final Station station;
  StationArgument({this.station});
}
