import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/infra/driver/device_connectivity_driver_mock.dart';

void main() {
  late DeviceConnectivityServiceImpl service;
  late DeviceConnectivityDriverMock driverMock;

  setUp(() {
    driverMock = DeviceConnectivityDriverMock();
    service = DeviceConnectivityServiceImpl(
      driver: driverMock,
    );
  });

  group('DeviceConnectivityServiceImpl Tests -', () {
    test('Should check internet connection with true return', () async {
      driverMock.success(result: true);
      final response = await service.hasInternetConnection();
      expect(response, true);
    });
    test('Should check internet connection with false return', () async {
      driverMock.success(result: false);
      final response = await service.hasInternetConnection();
      expect(response, false);
    });

    test('Should throw AppException for connectivity issue', () async {
      driverMock.error();
      try {
        await service.hasInternetConnection();
      } on AppException catch (e) {
        expect(e, isA<AppException>());
        expect(e.type, AppExceptionType.connectivityResponse);
        expect(
            e.message, 'Please check your Internet connection and try again.');
      }
    });
  });
}
