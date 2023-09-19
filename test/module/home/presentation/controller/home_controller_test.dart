import 'package:emergency_map/module/home/presentation/controller/controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../mocks/domain/usecases/usecases_mocks.dart';

void main() {
  late HomeController controller;

  late GetDeviceConnectivityUseCaseMock getDeviceConnectivityUseCaseMock;
  late GetDeviceGeolocationUseCaseMock getDeviceGeolocationUseCaseMock;
  late GetDeviceGpsEnabledUseCaseMock getDeviceGpsEnabledUseCaseMock;
  late GetGeolocationUseCaseMock getGeolocationUseCaseMock;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    getDeviceConnectivityUseCaseMock = GetDeviceConnectivityUseCaseMock();
    getDeviceGeolocationUseCaseMock = GetDeviceGeolocationUseCaseMock();
    getDeviceGpsEnabledUseCaseMock = GetDeviceGpsEnabledUseCaseMock();
    getGeolocationUseCaseMock = GetGeolocationUseCaseMock();

    controller = HomeController(
      getDeviceConnectivityUseCase: getDeviceConnectivityUseCaseMock,
      getDeviceGeolocationUseCase: getDeviceGeolocationUseCaseMock,
      getDeviceGpsEnabledUseCase: getDeviceGpsEnabledUseCaseMock,
      getGeolocationUseCase: getGeolocationUseCaseMock,
    );
  });

  group('HomeController Tests Success -', () {
    test('Should return initial values ​​correctly', () async {
      expect(controller.coordinates.value, const LatLng(0.0, 0.0));
      expect(controller.state.value, isA<HomeStateLoading>());
      expect(controller.marker.value, []);
    });

    test('Should return initial values ​​if GPS and internet are disabled',
        () async {
      getDeviceConnectivityUseCaseMock.success(result: false);
      getDeviceGpsEnabledUseCaseMock.success(result: false);

      await controller.getCurrentGeolocation();
      expect(controller.coordinates.value, const LatLng(0.0, 0.0));
      expect(controller.state.value, isA<HomeStateSuccess>());
      expect(controller.marker.value, []);
    });

    test(
        'Should return actual values ​​if GPS is enabled and internet is disabled',
        () async {
      getDeviceConnectivityUseCaseMock.success(result: false);
      getDeviceGpsEnabledUseCaseMock.success(result: true);
      getDeviceGeolocationUseCaseMock.success();

      await controller.getCurrentGeolocation();

      expect(controller.coordinates.value, const LatLng(-19.9029, -43.9572));
      expect(controller.state.value, isA<HomeStateSuccess>());
      expect(controller.marker.value, isNotEmpty);
    });

    test(
        'Should return actual values ​​if internet is enabled and GPS is disabled',
        () async {
      getDeviceConnectivityUseCaseMock.success(result: true);
      getDeviceGpsEnabledUseCaseMock.success(result: false);
      getGeolocationUseCaseMock.success();

      await controller.getCurrentGeolocation();

      expect(controller.coordinates.value, const LatLng(-19.9029, -43.9572));
      expect(controller.state.value, isA<HomeStateSuccess>());
      expect(controller.marker.value, isNotEmpty);
    });

    test('Should return correct marker values ​​after another request',
        () async {
      getDeviceConnectivityUseCaseMock.success(result: false);
      getDeviceGpsEnabledUseCaseMock.success(result: true);
      getDeviceGeolocationUseCaseMock.success();

      await controller.getCurrentGeolocation();

      expect(controller.coordinates.value, const LatLng(-19.9029, -43.9572));
      expect(controller.state.value, isA<HomeStateSuccess>());

      // New request using the HomePage onFetchLocation button
      await controller.getCurrentGeolocation();
      expect(controller.marker.value, isNotEmpty);
    });
  });

  group('HomeController Tests Failure -', () {
    test('Should handle error when checking Internet connectivity', () async {
      getDeviceConnectivityUseCaseMock.error();

      await controller.getCurrentGeolocation();

      expect(controller.coordinates.value, const LatLng(0.0, 0.0));
      expect(controller.marker.value, []);
      expect(controller.state.value, isA<HomeStateError>());
      expect(
        controller.state.value.message,
        'Please check your Internet connection and try again.',
      );
    });
    test('Should handle error when checking device GPS', () async {
      getDeviceConnectivityUseCaseMock.success(result: false);
      getDeviceGpsEnabledUseCaseMock.error();

      await controller.getCurrentGeolocation();

      expect(controller.coordinates.value, const LatLng(0.0, 0.0));
      expect(controller.marker.value, []);
      expect(controller.state.value, isA<HomeStateError>());
      expect(
        controller.state.value.message,
        'Check if there is Internet or GPS is active and try again.',
      );
    });

    test('Should handle error when checking device GPS permission denied',
        () async {
      getDeviceConnectivityUseCaseMock.success(result: false);
      getDeviceGpsEnabledUseCaseMock.errorPermissionDenied();

      await controller.getCurrentGeolocation();

      expect(controller.coordinates.value, const LatLng(0.0, 0.0));
      expect(controller.marker.value, []);
      expect(controller.state.value, isA<HomeStateError>());
      expect(
        controller.state.value.message,
        'Access your app settings and grant location permissions, and try again.',
      );
    });

    test('Should deal with error when trying to search for location by GPS',
        () async {
      getDeviceConnectivityUseCaseMock.success(result: false);
      getDeviceGpsEnabledUseCaseMock.errorPermissionDeniedForever();

      await controller.getCurrentGeolocation();

      expect(controller.coordinates.value, const LatLng(0.0, 0.0));
      expect(controller.marker.value, []);
      expect(controller.state.value, isA<HomeStateError>());
      expect(
        controller.state.value.message,
        'Access your app settings and enable location permissions, and try again.',
      );
    });

    test('Should handle error when trying to search for location by IP',
        () async {
      getDeviceConnectivityUseCaseMock.success(result: false);
      getDeviceGpsEnabledUseCaseMock.success(result: true);
      getDeviceGeolocationUseCaseMock.error();

      await controller.getCurrentGeolocation();

      expect(controller.coordinates.value, const LatLng(0.0, 0.0));
      expect(controller.state.value, isA<HomeStateError>());
      expect(
        controller.state.value.message,
        'We cannot retrieve your location. Please disable GPS, enable the internet, and try again.',
      );
    });

    test(
        'Should handle geolocation retrieval failure when GPS is disabled and no internet is available.',
        () async {
      getDeviceConnectivityUseCaseMock.success(result: true);
      getDeviceGpsEnabledUseCaseMock.success(result: false);
      getGeolocationUseCaseMock.error();

      await controller.getCurrentGeolocation();

      expect(controller.coordinates.value, const LatLng(0.0, 0.0));
      expect(controller.state.value, isA<HomeStateError>());
      expect(
        controller.state.value.message,
        'We cannot retrieve your location. Please disable internet, enable the GPS, and try again.',
      );
    });
  });
}
