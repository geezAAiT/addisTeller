import 'package:addis_teller_app/post/post.dart';
import 'package:addis_teller_app/station/screens/station_detail.dart';
import 'package:addis_teller_app/station/widgets/createAndUpdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../station.dart';

class AllStations extends StatelessWidget {
  AllStations({
    this.trailing,
  });
  final bool trailing;
  String userID;

  final Radius borderRadius = Radius.circular(15);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<StationBloc, StationState>(
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
                      image: AssetImage('images/${stations[index].name}.jpg'),
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: size.height / 4,
                      // width: double.infinity,
                    ),
                    // ),
                  ),
                  ListTile(
                    onTap: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      userID = pref.getString("id");
                      BlocProvider.of<PostBloc>(context)
                          .add(StationPostLoad(stationID: stations[index].id));
                      Navigator.pushNamed(context, StationDetail.routeName,
                          arguments: stations[index]);
                    },
                    title: Text(
                      '${stations[index].name}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${stations[index].latLong}'),
                    trailing: trailing
                        ? IconButton(
                            icon: Icon(Icons.update),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => AddAndUpdateField(
                                        edit: true,
                                        station: stations[index],
                                      ));
                            })
                        : SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          child: Text("error"),
        );
      },
    );
  }
}
