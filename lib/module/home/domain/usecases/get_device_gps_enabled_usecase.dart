import '../services/device_geolocation_service.dart';

class GetDeviceGpsEnabledUseCase {
  final DeviceGeolocationService service;

  GetDeviceGpsEnabledUseCase({
    required this.service,
  });

  Future<bool> call() async {
    return await service.getDeviceGeolocationEnabled();
  }
}
