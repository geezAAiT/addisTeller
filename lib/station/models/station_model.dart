import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Station extends Equatable {
  Station({
    this.id,
    this.stations,
    this.name,
    this.latLong,
  });

  final List<dynamic> stations;
  final String id, name, latLong;

  @override
  List<Object> get props => [
        id,
        stations,
        name,
        latLong,
      ];

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['_id'],
      stations: json['stations'],
      name: json['name'],
      latLong: json['latLong'],
    );
  }

  @override
  String toString() =>
      'Station { id: $id, name: $name, latLong: $latLong, postStations: $stations }';
}
