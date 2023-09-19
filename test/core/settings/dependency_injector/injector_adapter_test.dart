import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/core/settings/settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Injector sut;

  setUp(() async {
    sut = InjectorAdapter();
  });

  group('InjectorAdapter Tests -', () {
    test('It should return the correct value of a registered Singleton', () {
      sut.registerLazySingleton<String>(
        instance: 'Test lazy singleton',
        instanceName: 'myTest',
      );
      final result = sut.getInstance<String>(instanceName: 'myTest');
      expect(result, 'Test lazy singleton');
    });

    test('It should throw an error trying to access a not registered type', () {
      try {
        sut.getInstance<int>();
      } on AppException catch (e) {
        expect(e.type, AppExceptionType.dependencyInjector);
        expect(e, isA<AppException>());
      }
    });
  });
}
