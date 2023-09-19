import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mocktail/mocktail.dart';

class ConnectivityMock extends Mock implements Connectivity {
  void success({required ConnectivityResult type}) {
    when(() => checkConnectivity()).thenAnswer(
      (_) => Future<ConnectivityResult>.value(type),
    );
  }

  void error() {
    when(() => checkConnectivity()).thenThrow(
      UnimplementedError('checkConnectivity() has not been implemented.'),
    );
  }
}
