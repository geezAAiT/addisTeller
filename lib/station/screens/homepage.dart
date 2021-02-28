import 'package:addis_teller_app/auth/screens/login.dart';
import 'package:addis_teller_app/post/bloc/post_bloc.dart';
import 'package:addis_teller_app/post/bloc/post_event.dart';
import 'package:addis_teller_app/station/screens/station_detail.dart';
import 'package:addis_teller_app/station/station.dart';
import 'package:addis_teller_app/station/widgets/createAndUpdate.dart';
import 'package:addis_teller_app/station/widgets/nearbyCarousel.dart';
import 'package:addis_teller_app/station/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  static String routeName = '/';
  @override
  _HomepageState createState() => _HomepageState();
}

String userID;

class _HomepageState extends State<Homepage> {
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
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          SearchForm(),
          NearbyCarousel(),
          BlocBuilder<StationBloc, StationState>(
            builder: (_, state) {
              if (state is StationOperationFailure) {
                return Text('${state.message}');
              }

              if (state is StationLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              // ${stations[idx].title}
              if (state is StationsLoadSuccess) {
                final stations = state.stations;

                return ListView.builder(
                  // scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: stations.length,
                  itemBuilder: (context, int index) => Card(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    // borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 15,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: borderRadius, topRight: borderRadius),
                          // child: Hero(
                          //   tag: stations[index].id,
                          child: Image(
                            image: AssetImage('images/hotel0.jpg'),
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: size.height / 4,
                            // width: double.infinity,
                          ),
                          // ),
                        ),
<<<<<<< HEAD
                        ListTile(
                          onTap: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            userID = pref.getString("id");
                            BlocProvider.of<PostBloc>(context).add(
                                StationPostLoad(stationID: stations[index].id));
                            Navigator.pushNamed(
                                context, StationDetail.routeName,
                                arguments: stations[index]);
                          },
                          title: Text(
                            '${stations[index].name}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${stations[index].latLong}'),
                          trailing: IconButton(
                              icon: Icon(Icons.update),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => AddAndUpdateField(
                                          edit: true,
                                          station: stations[index],
                                        ));
                              }),
                        ),
                      ],
=======
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        userID = pref.getString("id");
                        BlocProvider.of<PostBloc>(context).add(
                            StationPostLoad(stationID: stations[index].id));
                        Navigator.pushNamed(context, StationDetail.routeName,
                            arguments: stations[index]);
                      },
                      title: Text('${stations[index].name}'),
                      subtitle: Text('${stations[index].latLong}'),
                      trailing: IconButton(
                          icon: Icon(Icons.update),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => AddAndUpdateField(
                                      edit: true,
                                      station: stations[index],
                                    ));
                          }),
>>>>>>> b96b5064529db5d80a9c6809a407c595c8a79ae9
                    ),
                  ),
                );
              }

              return Container();
            },
          ),
        ],
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
    );
  }
}

class UserPage extends StatelessWidget {
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
    );
  }
}
