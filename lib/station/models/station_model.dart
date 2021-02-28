import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Station extends Equatable {
  Station({this.id, this.stations, this.name, this.latLong, this.posts});

  final List<dynamic> stations;
  final List<dynamic> posts;
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
        posts: json['posts']);
  }

  @override
  String toString() =>
      'Station { id: $id, name: $name, latLong: $latLong, stations: $stations, posts: $posts }';
<<<<<<< HEAD
}

@immutable
class Nearby extends Equatable {
  Nearby({this.station, this.distance});

  final Map<String, dynamic> station;
  final String distance;

  @override
  List<Object> get props => [station, distance];

  factory Nearby.fromJson(Map<String, dynamic> json) {
    return Nearby(
        station: json['station'], distance: json['distance'].toString());
  }

  @override
  String toString() => 'Station { station: $station, distance: $distance }';
=======
>>>>>>> b96b5064529db5d80a9c6809a407c595c8a79ae9
}
