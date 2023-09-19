import 'package:emergency_map/core/environment/app_environment.dart';
import 'package:emergency_map/core/settings/settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DioBaseNative dioBaseNative;

  setUp(() {
    dioBaseNative = DioBaseNative();
  });

  test('DioBaseNative Test - It should have a configuration base started',
      () async {
    expect(dioBaseNative.options.baseUrl, equals(AppEnvironment.apiBaseUrl));
    expect(dioBaseNative, isA<DioBaseNative>());
    expect(dioBaseNative.options.headers, {
      'content-type': 'application/json',
      'accept': 'application/json',
    });
    expect(dioBaseNative.interceptors, isNotEmpty);
    expect(getDioInstance(), isA<DioBaseNative>());
  });
}
