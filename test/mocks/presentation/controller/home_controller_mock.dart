import 'package:emergency_map/core/constants/app_images.dart';
import 'package:emergency_map/core/constants/app_text.dart';
import 'package:emergency_map/module/home/presentation/controller/controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter/material.dart';

class HomeStateNull extends HomeState {
  HomeStateNull();
  @override
  String get message => '';
}

class HomeControllerMock extends Mock implements HomeController {
  // ignore: prefer_final_fields
  Set<Marker> _marker = {};
  HomeState _state = HomeStateLoading();
  LatLng _coordinates = const LatLng(0.0, 0.0);

  @override
  Future<void> getCurrentGeolocation() async {
    when(() => coordinates).thenReturn(ValueNotifier(_coordinates));
    when(() => state).thenReturn(ValueNotifier(_state));
    when(() => marker).thenReturn(ValueNotifier(_marker));
  }

  void success() {
    _coordinates = const LatLng(-19.9029, -43.9572);
    _state = HomeStateSuccess();
    _setPinMarker();
  }

  void error() {
    _state = HomeStateError(
      message: AppText.internetError,
    );
  }

  void errorUnexpected() {
    _state = HomeStateNull();
  }

  void coordinatesEmpty() {
    _state = HomeStateSuccess();
  }

  Future<void> _setPinMarker() async {
    final BitmapDescriptor iconPin = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5), AppImages.pin);

    final Marker pin = Marker(
      markerId: const MarkerId('PIN_ID'),
      position: _coordinates,
      draggable: true,
      icon: iconPin,
    );

    _marker.add(pin);
  }
}
