import 'package:emergency_map/module/home/domain/usecases/get_device_gps_enabled_usecase.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/error/app_exception.dart';

import '../../home.dart';
import 'home_state.dart';

class HomeController {
  final GetDeviceGeolocationUseCase _getDeviceGeolocationUseCase;
  final GetDeviceConnectivityUseCase _getDeviceConnectivityUseCase;
  final GetGeolocationUseCase _getGeolocationUseCase;
  final GetDeviceGpsEnabledUseCase _getDeviceGpsEnabledUseCase;

  HomeController({
    required GetDeviceGeolocationUseCase getDeviceGeolocationUseCase,
    required GetDeviceConnectivityUseCase getDeviceConnectivityUseCase,
    required GetGeolocationUseCase getGeolocationUseCase,
    required GetDeviceGpsEnabledUseCase getDeviceGpsEnabledUseCase,
  })  : _getDeviceGeolocationUseCase = getDeviceGeolocationUseCase,
        _getDeviceConnectivityUseCase = getDeviceConnectivityUseCase,
        _getGeolocationUseCase = getGeolocationUseCase,
        _getDeviceGpsEnabledUseCase = getDeviceGpsEnabledUseCase;

// _____________________________________________________________________________

  ValueNotifier<LatLng> coordinates = ValueNotifier(const LatLng(0.0, 0.0));
  ValueNotifier<HomeState> state = ValueNotifier(HomeStateLoading());
  ValueNotifier<Set<Marker>> marker = ValueNotifier({});

// _____________________________________________________________________________

  Future<void> getCurrentGeolocation() async {
    try {
      state.value = HomeStateLoading();

      final bool hasInternetConnection = await _getDeviceConnectivityUseCase();
      final bool hasDeviceGpsEnabled = await _getDeviceGpsEnabledUseCase();

      if (hasDeviceGpsEnabled) {
        await _getGeolocationGPS();
        await _setPinMarker();
      } else if (hasInternetConnection) {
        await _getGeolocationIP();
        await _setPinMarker();
      }
      state.value = HomeStateSuccess();
    } on AppException catch (e) {
      state.value = HomeStateError(
        message: e.message!,
      );
    }
  }

  Future<void> _getGeolocationIP() async {
    return await _getGeolocationUseCase().then((coords) {
      _updateCoordinates(
        latitude: coords.latitude,
        longitude: coords.longitude,
      );
    });
  }

  Future<void> _getGeolocationGPS() async {
    return _getDeviceGeolocationUseCase().then((coords) {
      _updateCoordinates(
        latitude: coords.latitude,
        longitude: coords.longitude,
      );
    });
  }

  void _updateCoordinates({
    required double latitude,
    required double longitude,
  }) {
    coordinates.value = LatLng(latitude, longitude);
  }

  Future<void> _setPinMarker() async {
    try {
      final BitmapDescriptor iconPin = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 2.5), AppImages.pin);

      final Marker pin = Marker(
        markerId: const MarkerId('PIN_ID'),
        position: coordinates.value,
        draggable: true,
        icon: iconPin,
      );

      if (marker.value.isNotEmpty) {
        marker.value.clear();
      }

      marker.value.add(pin);
    } catch (_) {
      state.value = HomeStateError(
        message: AppText.genericError,
      );
      rethrow;
    }
  }
}
