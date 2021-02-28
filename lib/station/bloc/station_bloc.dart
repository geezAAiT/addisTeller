import 'package:addis_teller_app/station/station.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  final StationRepository stationRepository;

  StationBloc({@required this.stationRepository})
      : assert(stationRepository != null),
        super(StationLoading());

  @override
  Stream<StationState> mapEventToState(StationEvent event) async* {
    if (event is StationLoad) {
      yield StationLoading();
      try {
        final stations = await stationRepository.getStations();
        print(stations);
        yield StationsLoadSuccess(stations);
      } catch (e) {
        yield StationOperationFailure(message: '$e');
      }
    }

    if (event is StationCreate) {
      try {
        await stationRepository.createStation(event.station);
        final stations = await stationRepository.getStations();
        yield StationsLoadSuccess(stations);
      } catch (e) {
        yield StationOperationFailure(message: '$e');
      }
    }

    if (event is StationUpdate) {
      try {
        await stationRepository.updateStation(event.station);
        final stations = await stationRepository.getStations();
        yield StationsLoadSuccess(stations);
      } catch (_) {
        yield StationOperationFailure();
      }
    }

    if (event is StationDelete) {
      try {
        await stationRepository.deleteStation(event.station.id);
        final stations = await stationRepository.getStations();
        yield StationsLoadSuccess(stations);
      } catch (_) {
        yield StationOperationFailure();
      }
    }
    if (event is NearbyLoad) {
      yield NearbyLoading();
      try {
        final nearbys =
            await stationRepository.getNearbyStations(event.currentCoordinate);
        print(nearbys);
        yield NearbysLoadSuccess(nearbys);
      } catch (e) {
        yield NearbyOperationFailure(message: '$e');
      }
    }
  }
}
