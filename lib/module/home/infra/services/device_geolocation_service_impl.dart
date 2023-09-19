import '../../domain/services/device_geolocation_service.dart';
import '../drivers/device_geolocation_driver.dart';

class DeviceGeolocationServiceImpl implements DeviceGeolocationService {
  final DeviceGeolocationDriver driver;
  DeviceGeolocationServiceImpl({
    required this.driver,
  });

  @override
  Future<({double latitude, double longitude})> getDeviceGeolocation() async {
    return await driver.getDeviceGeolocation();
  }

  @override
  Future<bool> getDeviceGeolocationEnabled() async {
    return await driver.getDeviceGeolocationEnabled();
  }
}
