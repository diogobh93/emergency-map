import 'package:emergency_map/core/constants/app_text.dart';
import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:mocktail/mocktail.dart';

class GeolocationRepositoryMock extends Mock implements GeolocationRepository {
  void success() {
    when(() => getRemoteGeolocationIP()).thenAnswer(
      (_) => Future<({double latitude, double longitude})>.value(
        (
          latitude: -19.9029,
          longitude: -43.9572,
        ),
      ),
    );
  }

  void errorDataEmpty() {
    when(() => getRemoteGeolocationIP()).thenThrow(
      AppException(
        type: AppExceptionType.geolocationIP,
        message: AppText.locationDataRetrievalError,
      ),
    );
  }

  void error() {
    when(() => getRemoteGeolocationIP()).thenThrow(
      AppException(
        type: AppExceptionType.geolocationIP,
        message: AppText.locationInternetError,
      ),
    );
  }
}
