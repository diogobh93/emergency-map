import 'package:emergency_map/core/constants/app_text.dart';
import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/domain/usecases/get_device_gps_enabled_usecase.dart';
import 'package:mocktail/mocktail.dart';

class GetDeviceGpsEnabledUseCaseMock extends Mock
    implements GetDeviceGpsEnabledUseCase {
  void success({required bool result}) {
    when(() => call()).thenAnswer(
      (_) => Future<bool>.value(result),
    );
  }

  void error() {
    when(() => call()).thenThrow(
      AppException(
        type: AppExceptionType.gpsServiceDisabled,
        message: AppText.genericError,
      ),
    );
  }

  void errorPermissionDenied() {
    when(() => call()).thenThrow(
      AppException(
        type: AppExceptionType.gpsPermissionDenied,
        message: AppText.locationPermissionsError,
      ),
    );
  }

  void errorPermissionDeniedForever() {
    when(() => call()).thenThrow(
      AppException(
        type: AppExceptionType.gpsPermissionDeniedForever,
        message: AppText.locationPermissionsPermanentError,
      ),
    );
  }
}
