import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/module/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/external/drivers/connectivity_plus_mock.dart';

void main() {
  late ConnectivityLocalDriverImpl driverImpl;
  late ConnectivityMock connectivityMock;

  setUp(() {
    connectivityMock = ConnectivityMock();
    driverImpl = ConnectivityLocalDriverImpl(connectivity: connectivityMock);
  });

  group('ConnectivityLocalDriverImpl Tests -', () {
    test('Should check internet connection with true return for wifi type',
        () async {
      connectivityMock.success(type: ConnectivityResult.wifi);
      final response = await driverImpl.hasInternetConnection();
      expect(response, true);
    });

    test('check internet connection with true return for ethernet type',
        () async {
      connectivityMock.success(type: ConnectivityResult.ethernet);
      final response = await driverImpl.hasInternetConnection();
      expect(response, true);
    });

    test('check internet connection with false return for bluetooh type',
        () async {
      connectivityMock.success(type: ConnectivityResult.bluetooth);
      final response = await driverImpl.hasInternetConnection();
      expect(response, false);
    });

    test('check internet connection with false return for vpn type', () async {
      connectivityMock.success(type: ConnectivityResult.vpn);
      final response = await driverImpl.hasInternetConnection();
      expect(response, false);
    });

    test('check internet connection with false return for other type',
        () async {
      connectivityMock.success(type: ConnectivityResult.other);
      final response = await driverImpl.hasInternetConnection();
      expect(response, false);
    });

    test('check internet connection with false return for none type', () async {
      connectivityMock.success(type: ConnectivityResult.none);
      final response = await driverImpl.hasInternetConnection();
      expect(response, false);
    });

    test('Should throw AppException for connectivity issue', () async {
      connectivityMock.error();
      try {
        await driverImpl.hasInternetConnection();
      } on AppException catch (e) {
        expect(e, isA<AppException>());
        expect(e.type, AppExceptionType.connectivityResponse);
        expect(
            e.message, 'Please check your Internet connection and try again.');
      }
    });
  });
}
