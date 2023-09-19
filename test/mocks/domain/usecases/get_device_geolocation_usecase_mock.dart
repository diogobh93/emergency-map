import 'package:emergency_map/core/constants/app_text.dart';
import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:mocktail/mocktail.dart';

class GetDeviceGeolocationUseCaseMock extends Mock
    implements GetDeviceGeolocationUseCase {
  void success() {
    when(() => call()).thenAnswer(
      (_) => Future<({double latitude, double longitude})>.value(
        (
          latitude: -19.9029,
          longitude: -43.9572,
        ),
      ),
    );
  }

  void error() {
    when(() => call()).thenThrow(
      AppException(
        type: AppExceptionType.gpsCurrentPosition,
        message: AppText.locationError,
      ),
    );
  }
}
