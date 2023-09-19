import '../../domain/services/device_connectivity_service.dart';
import '../drivers/device_connectivity_driver.dart';

class DeviceConnectivityServiceImpl implements DeviceConnectivityService {
  final DeviceConnectivityDriver driver;
  DeviceConnectivityServiceImpl({
    required this.driver,
  });

  @override
  Future<bool> hasInternetConnection() async {
    return await driver.hasInternetConnection();
  }
}
