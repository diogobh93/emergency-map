import '../../domain/repository/geolocation_repository.dart';
import '../datasource/geolocation_datasource.dart';

class GeolocationRepositoryImpl implements GeolocationRepository {
  final GeolocationDataSource datasource;
  GeolocationRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<({double latitude, double longitude})> getRemoteGeolocationIP() async {
    return await datasource.getRemoteGeolocationIP();
  }
}
