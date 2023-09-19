import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/domain/repository/geolocation_repository_mock.dart';

void main() {
  late GetGeolocationUseCase useCase;
  late GeolocationRepositoryMock repositoryMock;

  setUp(() {
    repositoryMock = GeolocationRepositoryMock();
    useCase = GetGeolocationUseCase(
      repository: repositoryMock,
    );
  });

  group('GetGeolocationUseCase Tests -', () {
    test('Should return correct IP geolocation data', () async {
      repositoryMock.success();
      final response = await useCase();
      expect(response.latitude, -19.9029);
      expect(response.longitude, -43.9572);
    });

    test('Should throw AppException for IP geolocation issue', () async {
      repositoryMock.error();
      try {
        await useCase();
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
      repositoryMock.errorDataEmpty();
      try {
        await useCase();
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
