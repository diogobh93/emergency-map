import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/domain/usecases/get_device_gps_enabled_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../mocks/domain/service/device_geolocation_service_mock.dart';

void main() {
  late GetDeviceGpsEnabledUseCase useCase;
  late DeviceGeolocationServiceMock serviceMock;

  setUp(() {
    serviceMock = DeviceGeolocationServiceMock();
    useCase = GetDeviceGpsEnabledUseCase(
      service: serviceMock,
    );
  });

  group('GetDeviceGpsEnabledUseCase Tests -', () {
    test('Should check GPS enabled with true return', () async {
      serviceMock.successGeolocationEnabled(result: true);
      final response = await useCase();
      expect(response, true);
    });
    test('Should check GPS disabled with false return', () async {
      serviceMock.successGeolocationEnabled(result: false);
      final response = await useCase();
      expect(response, false);
    });

    test('Should throw AppException for GPS issue', () async {
      serviceMock.errorGeolocationEnabled();
      try {
        await useCase();
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
      serviceMock.errorPermissionDenied();
      try {
        await useCase();
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
      serviceMock.errorPermissionDeniedForever();
      try {
        await useCase();
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
