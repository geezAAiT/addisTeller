import 'package:addis_teller_app/station/station.dart';
import 'package:meta/meta.dart';

class StationRepository {
  final StationDataProvider stationDataProvider;

  StationRepository({@required this.stationDataProvider})
      : assert(stationDataProvider != null);

  Future<Station> createStation(Station station) async {
    return await stationDataProvider.createStation(station);
  }

  Future<List<Station>> getStations() async {
    return await stationDataProvider.getStations();
  }

  Future<List<Nearby>> getNearbyStations(String currentCoordinate) async {
    return await stationDataProvider.getNearbyStations(currentCoordinate);
  }

  Future<void> updateStation(Station station) async {
    return await stationDataProvider.updateStation(station);
  }

  Future<void> deleteStation(String id) async {
    return await stationDataProvider.deleteStation(id);
  }

  Future<List<StationFromSearch>> searchStation(String search) async {
    return await stationDataProvider.searchStations(search);
  }
}
