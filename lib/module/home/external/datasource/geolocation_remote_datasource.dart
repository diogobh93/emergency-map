import '../../../../core/constants/app_text.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/settings/http/http.dart';
import '../../infra/datasource/geolocation_datasource.dart';

class GeolocationRemoteDatasourceImpl implements GeolocationDataSource {
  final HTTP client;
  GeolocationRemoteDatasourceImpl({
    required this.client,
  });

  @override
  Future<({double latitude, double longitude})> getRemoteGeolocationIP() async {
    try {
      // Fetches approximate location data from api
      final response = await client.get();

      if (response.success != null && response.success!.data != null) {
        final double lat = response.success!.data!['lat'];
        final double lon = response.success!.data!['lon'];
        return (latitude: lat, longitude: lon);
      } else {
        throw AppException(
          type: AppExceptionType.geolocationIP,
          message: AppText.locationDataRetrievalError,
        );
      }
    } on AppException catch (_) {
      rethrow;
    } catch (_) {
      throw AppException(
        type: AppExceptionType.geolocationIP,
        message: AppText.locationInternetError,
      );
    }
  }
}
