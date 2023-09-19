import 'package:dio/dio.dart' hide Response;
import '../http/http.dart';
import '../http/http_status.dart';

class DioClientAdapter implements HTTP {
  final Dio dio;
  DioClientAdapter({
    required this.dio,
  });

  @override
  Future<HttpStatus> get({
    String? path,
    JSON? queryParams,
    JSON? headers,
  }) async {
    try {
      final response = await dio.get(
        path ?? '',
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return HttpStatus(
        success: (
          data: response.data,
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      final dynamic error = e.error;
      return HttpStatus(
        failure: (
          exception: e,
          statusCode: e.response?.statusCode ?? error?.osError?.errorCode,
          errorData: e.response?.data ?? error?.osError,
          message: e.message ?? error?.message,
        ),
      );
    } catch (e) {
      return HttpStatus(
        failure: (
          exception: e,
          statusCode: 404,
          errorData: null,
          message: 'Failed to process the request',
        ),
      );
    }
  }
}
