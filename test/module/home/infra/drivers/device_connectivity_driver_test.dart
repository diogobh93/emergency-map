import 'package:emergency_map/core/error/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/infra/driver/device_connectivity_driver_mock.dart';

void main() {
  late DeviceConnectivityDriverMock deviceConnectivityDriver;

  setUp(() {
    deviceConnectivityDriver = DeviceConnectivityDriverMock();
  });

  group('DeviceConnectivityDriver Test -', () {
    test('Should check internet connection with true return', () async {
      deviceConnectivityDriver.success(result: true);
      final response = await deviceConnectivityDriver.hasInternetConnection();
      expect(response, true);
    });
    test('Should check internet connection with false return', () async {
      deviceConnectivityDriver.success(result: false);
      final response = await deviceConnectivityDriver.hasInternetConnection();
      expect(response, false);
    });

    test('Should throw AppException for connectivity issue', () async {
      deviceConnectivityDriver.error();
      try {
        await deviceConnectivityDriver.hasInternetConnection();
      } on AppException catch (e) {
        expect(e, isA<AppException>());
        expect(e.type, AppExceptionType.connectivityResponse);
        expect(
            e.message, 'Please check your Internet connection and try again.');
      }
    });
  });
}
