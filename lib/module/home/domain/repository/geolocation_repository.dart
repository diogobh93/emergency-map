abstract class GeolocationRepository {
  Future<({double latitude, double longitude})> getRemoteGeolocationIP();
}
