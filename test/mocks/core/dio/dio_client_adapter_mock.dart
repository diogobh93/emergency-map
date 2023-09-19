import 'package:emergency_map/core/constants/app_text.dart';
import 'package:emergency_map/core/error/app_exception.dart';
import 'package:emergency_map/core/settings/settings.dart';
import 'package:mocktail/mocktail.dart';

class DioClientAdapterMock extends Mock implements DioClientAdapter {
  final HttpStatus _dataEmpty = HttpStatus(
    success: (
      data: null,
      statusCode: 200,
    ),
    failure: null,
  );

  final HttpStatus _data = HttpStatus(
    success: (
      data: {
        'status': 'success',
        'country': 'Brazil',
        'countryCode': 'BR',
        'region': 'MG',
        'regionName': 'Minas Gerais',
        'city': 'Belo Horizonte',
        'zip': '30000',
        'lat': -19.9029,
        'lon': -43.9572,
        'timezone': 'America/Sao_Paulo',
        'isp': ' INTERNET E SERVICOS DE TELECOMUNICACOES LTDA',
        'org': 'INTERNET E SERVICOS DE TELECOMUNICACOES LTDA',
        'as': 'AS271042 INTERNET E SERVICOS DE TELECOMUNICACOES LTDA',
        'query': '177.36.18.77'
      },
      statusCode: 200,
    ),
    failure: null,
  );

  void success() {
    when(() => get()).thenAnswer(
      (_) => Future<HttpStatus>.value(_data),
    );
  }

  void error() {
    when(() => get()).thenThrow(
      AppException(
        type: AppExceptionType.geolocationIP,
        message: AppText.locationInternetError,
      ),
    );
  }

  void errorGeneric() {
    when(() => get()).thenThrow(
      UnimplementedError(
        'An unexpected error has occurred.',
      ),
    );
  }

  void errorDataEmpty() {
    when(() => get()).thenAnswer(
      (_) => Future<HttpStatus>.value(_dataEmpty),
    );
  }
}
