import 'package:addis_teller_app/station/bloc/nearby_bloc.dart';
import 'package:addis_teller_app/station/bloc/station_state.dart';
import 'package:addis_teller_app/station/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearbyCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nearby Stations',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<NearbyBloc, StationState>(builder: (context, state) {
          if (state is NearbyOperationFailure) {
            return Text("${state.message}");
          }
          if (state is NearbysLoadSuccess) {
            final nearbys = state.nearbys;
            return Container(
              height: 220.0,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: nearbys.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    Nearby nearby = nearbys[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => DestinationScreen(
                        //       destination: destination,
                        //     ),
                        //   ),
                        // );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        width: 150,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Positioned(
                              bottom: 10.0,
                              child: Container(
                                height: 95.0,
                                width: 145.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${nearby.station["name"]}',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        nearby.station["latLong"],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 9,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Hero(
                                    tag: nearby.station["_id"],
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image(
                                        image: AssetImage("images/hotel0.jpg"),
                                        height: 125,
                                        width: 135,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    bottom: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${nearby.distance} away',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_disabled,
                                              color: Colors.white,
                                              size: 8,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'destination.country',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        })
        //
      ],
    );
  }
}
