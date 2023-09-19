import 'package:geolocator/geolocator.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/error/app_exception.dart';
import '../../infra/drivers/device_geolocation_driver.dart';

class GeolocationLocalDriverImpl implements DeviceGeolocationDriver {
  final Geolocator geolocator;

  GeolocationLocalDriverImpl({required this.geolocator});

  @override
  Future<({double latitude, double longitude})> getDeviceGeolocation() async {
    try {
      final response = await Geolocator.getCurrentPosition();
      return (latitude: response.latitude, longitude: response.longitude);
    } catch (_) {
      throw AppException(
        type: AppExceptionType.gpsCurrentPosition,
        message: AppText.locationError,
      );
    }
  }

  @override
  Future<bool> getDeviceGeolocationEnabled() async {
    try {
      bool gpsEnabled = false;
      late LocationPermission permission;

      gpsEnabled = await Geolocator.isLocationServiceEnabled();
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          throw AppException(
            type: AppExceptionType.gpsPermissionDenied,
            message: AppText.locationPermissionsError,
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw AppException(
          type: AppExceptionType.gpsPermissionDeniedForever,
          message: AppText.locationPermissionsPermanentError,
        );
      }
      return gpsEnabled;
    } on AppException catch (_) {
      rethrow;
    } catch (_) {
      throw AppException(
        type: AppExceptionType.gpsServiceDisabled,
        message: AppText.genericError,
      );
    }
  }
}
