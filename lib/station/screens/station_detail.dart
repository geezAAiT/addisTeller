import 'package:addis_teller_app/auth/auth.dart';
import 'package:addis_teller_app/station/screens/admin_homepage.dart';
import 'package:addis_teller_app/station/screens/homepage.dart';
import 'package:addis_teller_app/station/station.dart';
import 'package:addis_teller_app/station/widgets/post_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StationDetail extends StatefulWidget {
  StationDetail({this.station});
  final Station station;
  static String routeName = '/detailPage';

  @override
  _StationDetailState createState() => _StationDetailState();
}

class _StationDetailState extends State<StationDetail>
    with SingleTickerProviderStateMixin {
  final _kTabs = <Tab>[
    const Tab(
        icon: Icon(
      Icons.post_add,
      color: Colors.black,
    )),
    const Tab(
        icon: Icon(
      Icons.details,
      color: Colors.black,
    )),
  ];
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: _kTabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                      child: Image(
                        image: AssetImage(
                            'images/${this.widget.station.name}.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is LoggedInUserSuccessState) {
                              final user = state.user;
                              return user.isAdmin
                                  ? IconButton(
                                      icon: Icon(Icons.delete),
                                      iconSize: 25.0,
                                      color: Colors.black,
                                      onPressed: () {
                                        BlocProvider.of<StationBloc>(context)
                                            .add(StationDelete(
                                                this.widget.station));
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                AdminHomepage.routeName,
                                                (route) => false);
                                      },
                                    )
                                  : SizedBox.shrink();
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20.0,
                    bottom: 20.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.station.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          widget.station.latLong,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20.0,
                    bottom: 20.0,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.purple,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                  itemCount: widget.station.stations.length,
                  itemBuilder: (BuildContext context, int index) {
                    final childStation = this.widget.station.stations[index];
                    return Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                          height: 120.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(80.0, 20.0, 20.0, 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 90.0,
                                      child: Text(
                                        childStation["name"],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          '${childStation["stations"].length}',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  childStation["latLong"],
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20.0,
                          top: 15.0,
                          bottom: 15.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              width: 90.0,
                              // height: 50,
                              image: AssetImage(
                                'images/${childStation["name"]}.jpg',
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is LoggedInUserSuccessState) {
              return PostTab(
                station: this.widget.station,
                userID: userID,
                isAdmin: state.user.isAdmin,
              );
            }
            return Container();
          })
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.grey,
        child: TabBar(
          tabs: _kTabs,
          controller: tabController,
        ),
      ),
    );
  }
}
