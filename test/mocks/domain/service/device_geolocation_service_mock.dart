import 'package:emergency_map/core/constants/app_text.dart';
import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:mocktail/mocktail.dart';

class DeviceGeolocationServiceMock extends Mock
    implements DeviceGeolocationService {
  // _________________getDeviceGeolocation_____________________________________

  void success() {
    when(() => getDeviceGeolocation()).thenAnswer(
      (_) => Future<({double latitude, double longitude})>.value(
        (
          latitude: -19.9029,
          longitude: -43.9572,
        ),
      ),
    );
  }

  void error() {
    when(() => getDeviceGeolocation()).thenThrow(
      AppException(
        type: AppExceptionType.gpsCurrentPosition,
        message: AppText.locationError,
      ),
    );
  }

// _________________getDeviceGeolocationEnabled________________________________

  void successGeolocationEnabled({required bool result}) {
    when(() => getDeviceGeolocationEnabled()).thenAnswer(
      (_) => Future<bool>.value(result),
    );
  }

  void errorGeolocationEnabled() {
    when(() => getDeviceGeolocationEnabled()).thenThrow(
      AppException(
        type: AppExceptionType.gpsServiceDisabled,
        message: AppText.genericError,
      ),
    );
  }

  void errorPermissionDenied() {
    when(() => getDeviceGeolocationEnabled()).thenThrow(
      AppException(
        type: AppExceptionType.gpsPermissionDenied,
        message: AppText.locationPermissionsError,
      ),
    );
  }

  void errorPermissionDeniedForever() {
    when(() => getDeviceGeolocationEnabled()).thenThrow(
      AppException(
        type: AppExceptionType.gpsPermissionDeniedForever,
        message: AppText.locationPermissionsPermanentError,
      ),
    );
  }
}
