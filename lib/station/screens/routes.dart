import 'package:addis_teller_app/auth/screens/login.dart';
<<<<<<< HEAD
import 'package:addis_teller_app/auth/screens/register.dart';
=======
>>>>>>> b96b5064529db5d80a9c6809a407c595c8a79ae9
import 'package:addis_teller_app/multi.dart';
import 'package:addis_teller_app/station/screens/homepage.dart';
import 'package:addis_teller_app/station/screens/station_detail.dart';
import 'package:addis_teller_app/station/station.dart';
import 'package:flutter/material.dart';

class StationAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => Homepage());
    }
    if (settings.name == Login.routeName) {
      return MaterialPageRoute(builder: (context) => Login());
    }
    if (settings.name == Register.routeName) {
      return MaterialPageRoute(builder: (context) => Register());
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
