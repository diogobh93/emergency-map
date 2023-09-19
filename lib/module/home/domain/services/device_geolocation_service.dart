abstract class DeviceGeolocationService {
  Future<({double latitude, double longitude})> getDeviceGeolocation();
  Future<bool> getDeviceGeolocationEnabled();
}
