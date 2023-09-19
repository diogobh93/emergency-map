import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/infra/datasource/geolocation_datasource_mock.dart';

void main() {
  late GeolocationRepositoryImpl repository;
  late GeolocationDataSourceMock datasourceMock;

  setUp(() {
    datasourceMock = GeolocationDataSourceMock();
    repository = GeolocationRepositoryImpl(
      datasource: datasourceMock,
    );
  });

  group('GeolocationRepositoryImpl Tests -', () {
    test('Should return correct IP geolocation data', () async {
      datasourceMock.success();
      final response = await repository.getRemoteGeolocationIP();
      expect(response.latitude, -19.9029);
      expect(response.longitude, -43.9572);
    });

    test('Should throw AppException for IP geolocation issue', () async {
      datasourceMock.error();
      try {
        await repository.getRemoteGeolocationIP();
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
      datasourceMock.errorDataEmpty();
      try {
        await repository.getRemoteGeolocationIP();
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
