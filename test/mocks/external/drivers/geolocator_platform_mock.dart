import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: depend_on_referenced_packages
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class GeolocatorPlatformMock extends Mock
    with MockPlatformInterfaceMixin
    implements GeolocatorPlatform {
  Future<bool> _isLocationServiceEnabled = Future<bool>.value(true);
  Future<LocationPermission> _permission = Future<LocationPermission>.value(
    LocationPermission.always,
  );

  Future<Position> _position = Future.value(Position(
    latitude: -19.9029,
    longitude: -43.9572,
    timestamp: DateTime.now(),
    altitude: 0.0,
    accuracy: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
  ));

  void locationServiceEnabled({bool? result, bool? hasError}) {
    if (hasError ?? false) {
      _isLocationServiceEnabled = Future.error(
        UnimplementedError(
          'isLocationServiceEnabled() has not been implemented',
        ),
      );
    } else {
      _isLocationServiceEnabled = Future<bool>.value(result ?? false);
    }
  }

  void permission({LocationPermission? type, bool? hasError}) {
    if (hasError ?? false) {
      _permission = Future.error(
        UnimplementedError(
          'checkPermission() has not been implemented.',
        ),
      );
    } else {
      _permission = Future<LocationPermission>.value(
        type ?? LocationPermission.always,
      );
    }
  }

  void currentPosition({bool? hasError}) {
    if (hasError ?? false) {
      _position = Future.error(
        UnimplementedError(
          'getCurrentPosition() has not been implemented.',
        ),
      );
    }
  }

  @override
  Future<LocationPermission> checkPermission() => Future.value(_permission);

  @override
  Future<bool> isLocationServiceEnabled() =>
      Future.value(_isLocationServiceEnabled);

  @override
  Future<Position> getCurrentPosition({
    LocationSettings? locationSettings,
  }) =>
      _position;

  @override
  Future<LocationPermission> requestPermission() => Future.value(_permission);
}
