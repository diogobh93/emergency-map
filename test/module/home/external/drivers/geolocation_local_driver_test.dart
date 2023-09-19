import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../mocks/external/drivers/geolocator_platform_mock.dart';

void main() {
  late GeolocationLocalDriverImpl driverImpl;
  late GeolocatorPlatformMock geolocatorPlatformMock;

  setUp(() {
    geolocatorPlatformMock = GeolocatorPlatformMock();
    GeolocatorPlatform.instance = geolocatorPlatformMock;
    driverImpl = GeolocationLocalDriverImpl(geolocator: Geolocator());
  });

  group('GeolocationLocalDriverImpl GetDeviceGeolocation Tests -', () {
    test('Should check device geolocation with return success', () async {
      geolocatorPlatformMock.locationServiceEnabled(result: true);
      final response = await driverImpl.getDeviceGeolocation();
      expect(response.latitude, -19.9029);
      expect(response.longitude, -43.9572);
    });

    test('Should throw AppException for device geolocation issue', () async {
      geolocatorPlatformMock.currentPosition(hasError: true);
      try {
        await driverImpl.getDeviceGeolocation();
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
  group('GeolocationLocalDriverImpl GetDeviceGeolocationEnabled Tests -', () {
    test('Should check GPS enabled with true return', () async {
      geolocatorPlatformMock.locationServiceEnabled(result: true);
      final response = await driverImpl.getDeviceGeolocationEnabled();
      expect(response, true);
    });
    test('Should check GPS disabled with false return', () async {
      geolocatorPlatformMock.locationServiceEnabled(result: false);
      final response = await driverImpl.getDeviceGeolocationEnabled();
      expect(response, false);
    });

    test('Should throw AppException for GPS issue', () async {
      geolocatorPlatformMock.locationServiceEnabled(hasError: true);
      try {
        await driverImpl.getDeviceGeolocationEnabled();
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
      geolocatorPlatformMock.locationServiceEnabled(result: true);
      geolocatorPlatformMock.permission(type: LocationPermission.denied);
      try {
        await driverImpl.getDeviceGeolocationEnabled();
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
      geolocatorPlatformMock.locationServiceEnabled(result: true);
      geolocatorPlatformMock.permission(type: LocationPermission.deniedForever);
      try {
        await driverImpl.getDeviceGeolocationEnabled();
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
