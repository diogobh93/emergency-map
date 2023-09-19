import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/core/dio/dio_client_adapter_mock.dart';

void main() {
  late GeolocationRemoteDatasourceImpl datasource;
  late DioClientAdapterMock clientMock;

  setUp(() {
    clientMock = DioClientAdapterMock();
    datasource = GeolocationRemoteDatasourceImpl(client: clientMock);
  });

  group('GeolocationRemoteDatasourceImpl Tests -', () {
    test('Should return correct IP geolocation data', () async {
      clientMock.success();
      final response = await datasource.getRemoteGeolocationIP();
      expect(response.latitude, -19.9029);
      expect(response.longitude, -43.9572);
    });

    test('Should throw AppException for IP geolocation issue', () async {
      clientMock.error();
      try {
        await datasource.getRemoteGeolocationIP();
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
      clientMock.errorDataEmpty();
      try {
        await datasource.getRemoteGeolocationIP();
      } on AppException catch (e) {
        expect(e, isA<AppException>());
        expect(e.type, AppExceptionType.geolocationIP);
        expect(
          e.message,
          'Check your Internet connection and ensure that location services are enabled, and try again.',
        );
      }
    });

    test('Should throw AppException for generic errors', () async {
      clientMock.errorGeneric();
      try {
        await datasource.getRemoteGeolocationIP();
      } on AppException catch (e) {
        expect(e, isA<AppException>());
        expect(e.type, AppExceptionType.geolocationIP);
        expect(
          e.message,
          'We cannot retrieve your location. Please disable internet, enable the GPS, and try again.',
        );
      }
    });
  });
}
