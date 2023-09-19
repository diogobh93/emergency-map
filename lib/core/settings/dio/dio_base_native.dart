import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../environment/app_environment.dart';

class DioBaseNative extends DioForNative {
  DioBaseNative() {
    options.baseUrl = AppEnvironment.apiBaseUrl;
    options.headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
      ),
    );
  }
}

Dio getDioInstance() => DioBaseNative();
