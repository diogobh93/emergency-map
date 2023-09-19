import 'package:emergency_map/core/constants/app_text.dart';
import 'package:emergency_map/module/home/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../utils/variants_screens_sizes.dart';

void main() {
  late AlertErrorWidget alertErrorWidget;
  bool retryCalled = false;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    alertErrorWidget = AlertErrorWidget(
      message: AppText.genericError,
      onFetchLocation: () {
        retryCalled = true;
      },
    );
  });

  group('AlertErrorWidget Test -', () {
    testWidgets(
      'Basic layout test (Mobile Device)',
      (tester) async {
        await tester.pumpWidget(MaterialApp(home: alertErrorWidget));

        final device = getDevice(responsiveVariant.currentValue!);

        final size = Size(device.width, device.height);
        await tester.binding.setSurfaceSize(size);

        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = device.pixelRatio;
      },
      variant: responsiveVariant,
    );
    testWidgets('Should correctly display the AlertErrorWidget',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: alertErrorWidget));

      expect(find.byType(AlertErrorWidget), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Should return true after tapping ElevatedButton button',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: alertErrorWidget));

      final elevatedButtonFinder = find.byType(ElevatedButton);

      expect(elevatedButtonFinder, findsOneWidget);

      await tester.tap(elevatedButtonFinder);

      await tester.pump();

      expect(retryCalled, isTrue);
    });
  });
}
