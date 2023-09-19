import 'package:emergency_map/core/error/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/domain/service/device_connectivity_service_mock.dart';

void main() {
  late DeviceConnectivityServiceMock deviceConnectivityService;

  setUp(() {
    deviceConnectivityService = DeviceConnectivityServiceMock();
  });

  group('DeviceConnectivityService Test -', () {
    test('Should check internet connection with true return', () async {
      deviceConnectivityService.success(result: true);
      final response = await deviceConnectivityService.hasInternetConnection();
      expect(response, true);
    });
    test('Should check internet connection with false return', () async {
      deviceConnectivityService.success(result: false);
      final response = await deviceConnectivityService.hasInternetConnection();
      expect(response, false);
    });

    test('Should throw AppException for connectivity issue', () async {
      deviceConnectivityService.error();
      try {
        await deviceConnectivityService.hasInternetConnection();
      } on AppException catch (e) {
        expect(e, isA<AppException>());
        expect(e.type, AppExceptionType.connectivityResponse);
        expect(
            e.message, 'Please check your Internet connection and try again.');
      }
    });
  });
}
