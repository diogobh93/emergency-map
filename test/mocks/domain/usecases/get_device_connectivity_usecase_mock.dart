import 'package:emergency_map/core/constants/app_text.dart';
import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:mocktail/mocktail.dart';

class GetDeviceConnectivityUseCaseMock extends Mock
    implements GetDeviceConnectivityUseCase {
  void success({required bool result}) {
    when(() => call()).thenAnswer(
      (_) => Future<bool>.value(result),
    );
  }

  void error() {
    when(() => call()).thenThrow(
      AppException(
        type: AppExceptionType.connectivityResponse,
        message: AppText.internetError,
      ),
    );
  }
}
