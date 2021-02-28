import 'package:addis_teller_app/station/station.dart';
import 'package:equatable/equatable.dart';

abstract class StationEvent extends Equatable {
  const StationEvent();
}

class StationLoad extends StationEvent {
  const StationLoad();

  @override
  List<Object> get props => [];
}

class NearbyLoad extends StationEvent {
  NearbyLoad({this.currentCoordinate});

  final String currentCoordinate;

  @override
  List<Object> get props => [currentCoordinate];
}

class StationCreate extends StationEvent {
  final Station station;

  const StationCreate(this.station);

  @override
  List<Object> get props => [station];

  @override
  String toString() => 'Station Created {station: $station}';
}

class StationUpdate extends StationEvent {
  final Station station;

  const StationUpdate(this.station);

  @override
  List<Object> get props => [station];

  @override
  String toString() => 'station Updated {station: $station}';
}

class StationDelete extends StationEvent {
  final Station station;

  const StationDelete(this.station);

  @override
  List<Object> get props => [station];

  @override
  toString() => 'station Deleted {station: $station}';
}
