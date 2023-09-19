import 'package:emergency_map/module/home/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../utils/variants_screens_sizes.dart';

void main() {
  late GoogleMapsWidget googleMapsWidget;
  bool retryCalled = false;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    googleMapsWidget = GoogleMapsWidget(
      coordinates: const LatLng(0.0, 0.0),
      markers: const {},
      onFetchLocation: () {
        retryCalled = true;
      },
    );
  });

  group('GoogleMapsWidget Test -', () {
    testWidgets(
      'Basic layout test (Mobile Device)',
      (tester) async {
        await tester.pumpWidget(MaterialApp(home: googleMapsWidget));

        final device = getDevice(responsiveVariant.currentValue!);

        final size = Size(device.width, device.height);
        await tester.binding.setSurfaceSize(size);

        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = device.pixelRatio;
      },
      variant: responsiveVariant,
    );
    testWidgets('Should correctly display the GoogleMapsWidget',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: googleMapsWidget));

      expect(find.byType(GoogleMapsWidget), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byType(GoogleMap), findsOneWidget);
      expect(
        googleMapsWidget.coordinates,
        const LatLng(0.0, 0.0),
      );
      expect(googleMapsWidget.markers, isEmpty);
      expect(googleMapsWidget.onFetchLocation, isA<Function>());
    });

    testWidgets('Should return true after tapping FloatingActionButton button',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: googleMapsWidget));

      final floatingActionButtonFinder = find.byType(FloatingActionButton);

      expect(floatingActionButtonFinder, findsOneWidget);

      await tester.tap(floatingActionButtonFinder);

      await tester.pump();

      expect(retryCalled, isTrue);
    });
  });
}
