import 'package:emergency_map/core/error/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/domain/repository/geolocation_repository_mock.dart';

void main() {
  late GeolocationRepositoryMock geolocationRepository;

  setUp(() {
    geolocationRepository = GeolocationRepositoryMock();
  });

  group('GeolocationRepository Test -', () {
    test('Should return correct IP geolocation data', () async {
      geolocationRepository.success();
      final result = await geolocationRepository.getRemoteGeolocationIP();

      expect(result.latitude, -19.9029);
      expect(result.longitude, -43.9572);
    });

    test('Should throw AppException for IP geolocation issue', () async {
      geolocationRepository.error();
      try {
        await geolocationRepository.getRemoteGeolocationIP();
      } on AppException catch (e) {
        expect(e, isA<AppException>());
        expect(e.type, AppExceptionType.geolocationIP);
        expect(
          e.message,
          'We cannot retrieve your location. Please disable internet, enable the GPS, and try again.',
        );
      }
    });

    test('Should throw AppException for data empty issue', () async {
      geolocationRepository.errorDataEmpty();
      try {
        await geolocationRepository.getRemoteGeolocationIP();
      } on AppException catch (e) {
        expect(e, isA<AppException>());
        expect(e.type, AppExceptionType.geolocationIP);
        expect(
          e.message,
          'Check your Internet connection and ensure that location services are enabled, and try again.',
        );
      }
    });
  });
}
