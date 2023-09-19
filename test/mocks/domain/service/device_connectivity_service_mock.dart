import 'package:emergency_map/core/constants/app_text.dart';
import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:mocktail/mocktail.dart';

class DeviceConnectivityServiceMock extends Mock
    implements DeviceConnectivityService {
  void success({required bool result}) {
    when(() => hasInternetConnection()).thenAnswer(
      (_) => Future<bool>.value(result),
    );
  }

  void error() {
    when(() => hasInternetConnection()).thenThrow(
      AppException(
        type: AppExceptionType.connectivityResponse,
        message: AppText.internetError,
      ),
    );
  }
}
