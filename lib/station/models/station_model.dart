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
}

@immutable
class Nearby extends Equatable {
  Nearby({this.station, this.distance});

  final Map<String, dynamic> station;
  final String distance;
  List<Object> get props => [station, distance];
  @override
  factory Nearby.fromJson(Map<String, dynamic> json) {
    return Nearby(
        station: json['station'],
        distance: json['distance'].toStringAsFixed(2));
  }

  @override
  String toString() => 'Station { station: $station, distance: $distance }';
}

@immutable
class StationFromSearch extends Equatable {
  StationFromSearch({this.station});
  final Map<String,dynamic> station;

  factory StationFromSearch.fromJson(Map<String, dynamic> json) {
    return StationFromSearch(
      station: json['station'],
    );
  }
  List<Object> get props => [station];
  @override
  String toString() => 'Station search { station: $station}';
}
