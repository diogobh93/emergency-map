import 'package:flutter_test/flutter_test.dart';

//Apply height and width sizes in CSS or ViewPort measurement,
//sites to assist in new implementations below.
//
// https://viewportsizer.com/devices/
// https://yesviz.com/viewport/

class VariantsScreensSizes {
  const VariantsScreensSizes({
    required this.width,
    required this.height,
    required this.pixelRatio,
  });
  final double width, height;
  final double pixelRatio;
}

// Devices small
const appleIphone5 =
    VariantsScreensSizes(width: 320, height: 568, pixelRatio: 2.0);
const samsungNexusS =
    VariantsScreensSizes(width: 360, height: 600, pixelRatio: 2.0);

// Devices medium
const appleIphone6sPlus =
    VariantsScreensSizes(width: 414, height: 736, pixelRatio: 3.0);
const samsungNote10 =
    VariantsScreensSizes(width: 412, height: 869, pixelRatio: 2.7);

// Devices great
const appleIphone12ProMax =
    VariantsScreensSizes(width: 428, height: 926, pixelRatio: 3.0);
const googlePixel4XL =
    VariantsScreensSizes(width: 412, height: 869, pixelRatio: 3.5);

final responsiveVariant = ValueVariant<String>({
  'Apple iPhone5 / ViewPort: 320 x 568',
  'Samsung Nexus S / ViewPort: 360 x 600',
  'Apple iPhone 6s Plus / ViewPort: 414 x 736',
  'Samsung Note 10 / ViewPort: 412 x 869',
  'Apple iPhone 12 Pro Max / ViewPort: 428 x 926',
  'Google Pixel 4 XL / ViewPort: 412 x 869'
});

getDevice(String variant) {
  const Map devices = {
    'Apple iPhone5 / ViewPort: 320 x 568': appleIphone5,
    'Samsung Nexus S / ViewPort: 360 x 600': samsungNexusS,
    'Apple iPhone 6s Plus / ViewPort: 414 x 736': appleIphone6sPlus,
    'Samsung Note 10 / ViewPort: 412 x 869': samsungNote10,
    'Apple iPhone 12 Pro Max / ViewPort: 428 x 926': appleIphone12ProMax,
    'Google Pixel 4 XL / ViewPort: 412 x 869': googlePixel4XL,
  };
  return devices[variant];
}
