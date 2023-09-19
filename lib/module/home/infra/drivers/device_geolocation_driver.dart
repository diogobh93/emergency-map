abstract class DeviceGeolocationDriver {
  Future<({double latitude, double longitude})> getDeviceGeolocation();
  Future<bool> getDeviceGeolocationEnabled();
}
