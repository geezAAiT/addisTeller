import 'package:addis_teller_app/station/bloc/bloc.dart';
import 'package:addis_teller_app/station/bloc/station_bloc.dart';
import 'package:addis_teller_app/station/bloc/station_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchForm extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Container(
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
              return ListView.builder(
                  itemCount: stations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.car_rental),
                      ),
                      title: Text(stations[index].name),
                      subtitle: Text(stations[index].latLong),
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
