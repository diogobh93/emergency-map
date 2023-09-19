abstract class GeolocationDataSource {
  Future<({double latitude, double longitude})> getRemoteGeolocationIP();
}
