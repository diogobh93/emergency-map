import '../services/device_connectivity_service.dart';

class GetDeviceConnectivityUseCase {
  final DeviceConnectivityService service;

  GetDeviceConnectivityUseCase({
    required this.service,
  });

  Future<bool> call() async {
    return await service.hasInternetConnection();
  }
}
