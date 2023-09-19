import 'package:emergency_map/module/home/presentation/controller/controller.dart';
import 'package:emergency_map/module/home/presentation/home_page.dart';
import 'package:emergency_map/module/home/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../mocks/presentation/controller/home_controller_mock.dart';
import '../../../utils/variants_screens_sizes.dart';

void main() {
  late HomePage homePage;
  late HomeControllerMock controllerMock;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    controllerMock = HomeControllerMock();
    homePage = HomePage(controller: controllerMock);
  });

  group('HomePage Test States -', () {
    testWidgets(
      'Basic layout test (Mobile Device)',
      (tester) async {
        controllerMock.error();
        await tester.pumpWidget(MaterialApp(home: homePage));

        final device = getDevice(responsiveVariant.currentValue!);

        final size = Size(device.width, device.height);
        await tester.binding.setSurfaceSize(size);

        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = device.pixelRatio;
      },
      variant: responsiveVariant,
    );

    testWidgets('Should return correct in case coordinates empty',
        (tester) async {
      controllerMock.coordinatesEmpty();
      await tester.pumpWidget(MaterialApp(home: homePage));

      expect(find.byType(GoogleMapsWidget), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byType(GoogleMap), findsOneWidget);
      expect(homePage.controller.state.value, isA<HomeStateSuccess>());
      expect(homePage.controller.coordinates.value, const LatLng(0.0, 0.0));
      expect(homePage.controller.marker.value, isEmpty);
    });

    testWidgets('Should return correct on loading', (tester) async {
      await tester.pumpWidget(MaterialApp(home: homePage));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      expect(homePage.controller.state.value, isA<HomeStateLoading>());
      expect(
        homePage.controller.coordinates.value,
        const LatLng(0.0, 0.0),
      );
      expect(homePage.controller.marker.value, isEmpty);
    });

    testWidgets('Should return correct on success', (tester) async {
      controllerMock.success();
      await tester.pumpWidget(MaterialApp(home: homePage));

      expect(find.byType(GoogleMapsWidget), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byType(GoogleMap), findsOneWidget);
      expect(homePage.controller.state.value, isA<HomeStateSuccess>());
      expect(
        homePage.controller.coordinates.value,
        const LatLng(-19.9029, -43.9572),
      );
      expect(homePage.controller.marker.value, isNotEmpty);
    });

    testWidgets('Should return correct on error', (tester) async {
      controllerMock.error();
      await tester.pumpWidget(MaterialApp(home: homePage));

      expect(find.byType(AlertErrorWidget), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsOneWidget);

      expect(homePage.controller.state.value, isA<HomeStateError>());
      expect(homePage.controller.state.value.message,
          'Please check your Internet connection and try again.');
      expect(
        homePage.controller.coordinates.value,
        const LatLng(0.0, 0.0),
      );
      expect(homePage.controller.marker.value, isEmpty);
    });

    testWidgets('Should return state error unexpected', (tester) async {
      controllerMock.errorUnexpected();
      await tester.pumpWidget(
        MaterialApp(home: homePage),
      );

      expect(find.byType(AlertErrorWidget), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsOneWidget);

      expect(homePage.controller.coordinates.value, const LatLng(0.0, 0.0));
      expect(homePage.controller.marker.value, isEmpty);

      expect(
        find.text('Check if there is Internet or GPS is active and try again.'),
        findsOneWidget,
      );
    });
  });

  group('HomePage Test Touch Buttons -', () {
    testWidgets('OnFetchLocation should return correctly if HomeStateSuccess',
        (tester) async {
      controllerMock.success();
      await tester.pumpWidget(MaterialApp(home: homePage));

      controllerMock.success();
      await tester.tap(find.byType(FloatingActionButton));

      expect(controllerMock.state.value, isA<HomeStateSuccess>());
      expect(
        homePage.controller.coordinates.value,
        const LatLng(-19.9029, -43.9572),
      );
    });

    testWidgets('OnFetchLocation should return correctly if HomeStateError',
        (tester) async {
      controllerMock.error();
      await tester.pumpWidget(MaterialApp(home: homePage));

      expect(controllerMock.state.value, isA<HomeStateError>());
      expect(
        homePage.controller.coordinates.value,
        const LatLng(0.0, 0.0),
      );

      controllerMock.success();
      await tester.tap(find.byType(ElevatedButton));

      expect(controllerMock.state.value, isA<HomeStateSuccess>());
      expect(
        homePage.controller.coordinates.value,
        const LatLng(-19.9029, -43.9572),
      );
    });

    testWidgets('OnFetchLocation should return correctly if error unexpected',
        (tester) async {
      controllerMock.errorUnexpected();
      await tester.pumpWidget(
        MaterialApp(home: homePage),
      );
      expect(homePage.controller.coordinates.value, const LatLng(0.0, 0.0));

      controllerMock.success();
      await tester.tap(find.byType(ElevatedButton));

      expect(controllerMock.state.value, isA<HomeStateSuccess>());
      expect(
        homePage.controller.coordinates.value,
        const LatLng(-19.9029, -43.9572),
      );
    });
  });
}
