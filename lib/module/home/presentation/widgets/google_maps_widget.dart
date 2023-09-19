import 'package:emergency_map/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsWidget extends StatelessWidget {
  final LatLng coordinates;
  final Set<Marker> markers;
  final VoidCallback onFetchLocation;

  const GoogleMapsWidget({
    super.key,
    required this.coordinates,
    required this.markers,
    required this.onFetchLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.whiteOverlay,
        onPressed: onFetchLocation,
        child: const Icon(
          Icons.gps_fixed,
        ),
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: coordinates,
          zoom: 13.0000,
        ),
        mapType: MapType.normal,
        markers: markers,
      ),
    );
  }
}
