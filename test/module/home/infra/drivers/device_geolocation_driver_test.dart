import 'package:emergency_map/core/error/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/domain/service/device_geolocation_service_mock.dart';

void main() {
  late DeviceGeolocationServiceMock deviceGeolocationService;

  setUp(() {
    deviceGeolocationService = DeviceGeolocationServiceMock();
  });

  group('DeviceGeolocationService getDeviceGeolocation Tests -', () {
    test('Should check device geolocation with return success', () async {
      deviceGeolocationService.success();
      final response = await deviceGeolocationService.getDeviceGeolocation();
      expect(response.latitude, -19.9029);
      expect(response.longitude, -43.9572);
    });

    test('Should throw AppException for device geolocation issue', () async {
      deviceGeolocationService.error();
      try {
        await deviceGeolocationService.getDeviceGeolocation();
      } on AppException catch (e) {
        expect(e, isA<AppException>());
        expect(e.type, AppExceptionType.gpsCurrentPosition);
        expect(
          e.message,
          'We cannot retrieve your location. Please disable GPS, enable the internet, and try again.',
        );
      }
    });
  });

  group('DeviceGeolocationService getDeviceGpsEnabled Tests -', () {
    test('Should check GPS enabled with true return', () async {
      deviceGeolocationService.successGeolocationEnabled(result: true);
      final response =
          await deviceGeolocationService.getDeviceGeolocationEnabled();
      expect(response, true);
    });
    test('Should check GPS disabled with false return', () async {
      deviceGeolocationService.successGeolocationEnabled(result: false);
      final response =
          await deviceGeolocationService.getDeviceGeolocationEnabled();
      expect(response, false);
    });

    test('Should throw AppException for GPS issue', () async {
      deviceGeolocationService.errorGeolocationEnabled();
      try {
        await deviceGeolocationService.getDeviceGeolocationEnabled();
      } on AppException catch (e) {
        expect(e, isA<AppException>());
        expect(e.type, AppExceptionType.gpsServiceDisabled);
        expect(
          e.message,
          'Check if there is Internet or GPS is active and try again.',
        );
      }
    });

    test('Should throw AppException for denied GPS permission issue', () async {
      deviceGeolocationService.errorPermissionDenied();
      try {
        await deviceGeolocationService.getDeviceGeolocationEnabled();
      } on AppException catch (e) {
        expect(e, isA<AppException>());
        expect(e.type, AppExceptionType.gpsPermissionDenied);
        expect(
          e.message,
          'Access your app settings and grant location permissions, and try again.',
        );
      }
    });

    test('Should throw AppException for forever denied GPS permission issue',
        () async {
      deviceGeolocationService.errorPermissionDeniedForever();
      try {
        await deviceGeolocationService.getDeviceGeolocationEnabled();
      } on AppException catch (e) {
        expect(e, isA<AppException>());
        expect(e.type, AppExceptionType.gpsPermissionDeniedForever);
        expect(
          e.message,
          'Access your app settings and enable location permissions, and try again.',
        );
      }
    });
  });
}
