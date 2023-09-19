import 'package:emergency_map/module/home/presentation/controller/home_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeState Test -', () {
    test('HomeStateSuccess should have the correct message', () {
      final state = HomeStateSuccess();
      expect(state.message, 'Success state!');
    });

    test('HomeStateLoading should have the correct message', () {
      final state = HomeStateLoading();
      expect(state.message, 'Loading state!');
    });

    test('HomeStateError should have the correct message', () {
      const errorMessage = 'An error occurred';
      final state = HomeStateError(message: errorMessage);
      expect(state.message, errorMessage);
    });
  });
}
