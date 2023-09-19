import 'package:emergency_map/core/constants/app_text.dart';
import 'package:emergency_map/module/home/infra/drivers/device_connectivity_driver.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../core/error/app_exception.dart';

class ConnectivityLocalDriverImpl implements DeviceConnectivityDriver {
  final Connectivity connectivity;

  ConnectivityLocalDriverImpl({required this.connectivity});

  @override
  Future<bool> hasInternetConnection() async {
    try {
      final ConnectivityResult connectivityResult =
          await connectivity.checkConnectivity();

      switch (connectivityResult) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
        case ConnectivityResult.ethernet:
          return true;
        default:
          return false;
      }
    } catch (_) {
      throw AppException(
        type: AppExceptionType.connectivityResponse,
        message: AppText.internetError,
      );
    }
  }
}
