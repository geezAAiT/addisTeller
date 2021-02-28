import 'package:addis_teller_app/station/station.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearbyBloc extends Bloc<StationEvent, StationState> {
  final StationRepository stationRepository;

  NearbyBloc({@required this.stationRepository})
      : assert(stationRepository != null),
        super(StationLoading());

  @override
  Stream<StationState> mapEventToState(StationEvent event) async* {
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
