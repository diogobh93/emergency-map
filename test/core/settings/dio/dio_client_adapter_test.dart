import 'package:dio/io.dart';
import 'package:emergency_map/core/settings/settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DioClientAdapter client;

  void initClient({required String baseUrl}) {
    final dioForNative = DioForNative();
    dioForNative.options.baseUrl = baseUrl;
    client = DioClientAdapter(dio: dioForNative);
  }

  group('DioClientAdapter Tests -', () {
    test('It should throw an HttpStatus success', () async {
      initClient(baseUrl: 'http://ip-api.com/json/');
      final response = await client.get();
      expect(response.runtimeType, equals(HttpStatus));
      expect(response.success!.statusCode, 200);
      expect(response.success!.data, isNotNull);
    });
    test('It should generate an HttpStatus failure for a Generic error',
        () async {
      initClient(baseUrl: 'http://ip-api.com/');
      final response = await client.get();
      expect(response.runtimeType, equals(HttpStatus));
      expect(response.success, isNull);
      expect(response.failure!.statusCode, 404);
      expect(response.failure!.message, 'Failed to process the request');
    });

    test('It should generate an HttpStatus failure for a DioException',
        () async {
      initClient(baseUrl: 'http://ip-api.com.br/');
      final response = await client.get();
      expect(response.runtimeType, equals(HttpStatus));
      expect(response.success, isNull);
      expect(response.failure!.statusCode, 11001);
      expect(response.failure!.message, contains('Failed host lookup'));
    });
  });
}
