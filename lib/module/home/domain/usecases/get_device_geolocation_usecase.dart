import '../services/device_geolocation_service.dart';

class GetDeviceGeolocationUseCase {
  final DeviceGeolocationService service;

  GetDeviceGeolocationUseCase({
    required this.service,
  });

  Future<({double latitude, double longitude})> call() async {
    return await service.getDeviceGeolocation();
  }
}
