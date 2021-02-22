import 'package:addis_teller_app/station/station.dart';
import 'package:equatable/equatable.dart';

class StationState extends Equatable {
  const StationState();

  @override
  List<Object> get props => [];
}

class StationLoading extends StationState {}

class StationsLoadSuccess extends StationState {
  final List<Station> stations;

  StationsLoadSuccess([this.stations = const []]);

  @override
  List<Object> get props => [stations];
}

class StationOperationFailure extends StationState {
  final String message;
  StationOperationFailure({this.message});

  @override
  List<Object> get props => [message];
}
