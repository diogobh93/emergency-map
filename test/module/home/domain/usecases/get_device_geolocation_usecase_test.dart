import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/domain/service/device_geolocation_service_mock.dart';

void main() {
  late GetDeviceGeolocationUseCase useCase;
  late DeviceGeolocationServiceMock serviceMock;

  setUp(() {
    serviceMock = DeviceGeolocationServiceMock();
    useCase = GetDeviceGeolocationUseCase(
      service: serviceMock,
    );
  });

  group('GetDeviceGeolocationUseCase Tests -', () {
    test('Should check device geolocation with return success', () async {
      serviceMock.success();
      final response = await useCase();
      expect(response.latitude, -19.9029);
      expect(response.longitude, -43.9572);
    });

    test('Should throw AppException for device geolocation issue', () async {
      serviceMock.error();
      try {
        await useCase();
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
}
