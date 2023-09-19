import 'http_status.dart';

abstract class HTTP {
  Future<HttpStatus> get({
    String path,
    JSON? queryParams,
    JSON? headers,
  });
}
