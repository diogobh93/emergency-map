import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/infra/driver/device_geolocation_driver_mock.dart';

void main() {
  late DeviceGeolocationServiceImpl service;
  late DeviceGeolocationDriverMock driverMock;

  setUp(() {
    driverMock = DeviceGeolocationDriverMock();
    service = DeviceGeolocationServiceImpl(driver: driverMock);
  });

  group('GetDeviceGeolocation Tests -', () {
    test('Should check device geolocation with return success', () async {
      driverMock.success();
      final response = await service.getDeviceGeolocation();
      expect(response.latitude, -19.9029);
      expect(response.longitude, -43.9572);
    });

    test('Should throw AppException for device geolocation issue', () async {
      driverMock.error();
      try {
        await service.getDeviceGeolocation();
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

  group('GetDeviceGeolocationEnabled Tests -', () {
    test('Should check GPS enabled with true return', () async {
      driverMock.resultGPS(result: true);
      final response = await service.getDeviceGeolocationEnabled();
      expect(response, true);
    });
    test('Should check GPS disabled with false return', () async {
      driverMock.resultGPS(result: false);
      final response = await service.getDeviceGeolocationEnabled();
      expect(response, false);
    });

    test('Should throw AppException for GPS issue', () async {
      driverMock.errorGPS();
      try {
        await service.getDeviceGeolocationEnabled();
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
      driverMock.errorPermissionDenied();
      try {
        await service.getDeviceGeolocationEnabled();
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
      driverMock.errorPermissionDeniedForever();
      try {
        await service.getDeviceGeolocationEnabled();
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
