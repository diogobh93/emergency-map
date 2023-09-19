import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/domain/service/device_connectivity_service_mock.dart';

void main() {
  late GetDeviceConnectivityUseCase useCase;
  late DeviceConnectivityServiceMock serviceMock;

  setUp(() {
    serviceMock = DeviceConnectivityServiceMock();
    useCase = GetDeviceConnectivityUseCase(
      service: serviceMock,
    );
  });

  group('GetDeviceConnectivityUseCase Tests -', () {
    test('Should check internet connection with true return', () async {
      serviceMock.success(result: true);
      final response = await useCase();
      expect(response, true);
    });
    test('Should check internet connection with false return', () async {
      serviceMock.success(result: false);
      final response = await useCase();
      expect(response, false);
    });

    test('Should throw AppException for connectivity issue', () async {
      serviceMock.error();
      try {
        await useCase();
      } on AppException catch (e) {
        expect(e, isA<AppException>());
        expect(e.type, AppExceptionType.connectivityResponse);
        expect(
            e.message, 'Please check your Internet connection and try again.');
      }
    });
  });
}
