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

class NearbyLoading extends StationState {}

class NearbysLoadSuccess extends StationState {
  final List<Nearby> nearbys;

  NearbysLoadSuccess([this.nearbys = const []]);

  @override
  List<Object> get props => [nearbys];
}

class NearbyOperationFailure extends StationState {
  final String message;
  NearbyOperationFailure({this.message});

  @override
  List<Object> get props => [message];
}

class SearchingState extends StationState {}

class SearchSuccessState extends StationState {
  final List<StationFromSearch> stations;

  SearchSuccessState([this.stations = const []]);

  @override
  List<Object> get props => [stations];
}

class SearchFailureState extends StationState {
  final String message;
  SearchFailureState({this.message});

  @override
  List<Object> get props => [message];
}
