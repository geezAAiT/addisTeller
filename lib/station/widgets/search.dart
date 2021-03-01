import 'package:addis_teller_app/station/bloc/bloc.dart';
import 'package:addis_teller_app/station/bloc/station_bloc.dart';
import 'package:addis_teller_app/station/bloc/station_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchForm extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Stations",
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue,
                ),
                width: 50,
                height: 50,
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.search),
                    iconSize: 30,
                    onPressed: () {
                      BlocProvider.of<StationBloc>(context)
                          .add(StationSearch(search: searchController.text));
                    },
                  ),
                ),
              ),
            ],
          ),
          BlocConsumer<StationBloc, StationState>(builder: (context, state) {
            if (state is SearchingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SearchSuccessState) {
              final stations = state.stations;
              print("search station:= $stations");
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: stations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.car_rental),
                      ),
                      title: Text(stations[index].station["name"]),
                      subtitle: Text(stations[index].station["latLong"]),
                    );
                  });
            }
            return SizedBox.shrink();
          }, listener: (context, state) {
            if (state is SearchFailureState) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('${state.message}')));
            }
          })
        ],
      ),
    );
  }
}
