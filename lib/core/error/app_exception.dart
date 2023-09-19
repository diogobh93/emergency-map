enum AppExceptionType {
  dependencyInjector,
  connectivityResponse,
  gpsCurrentPosition,
  gpsServiceDisabled,
  gpsPermissionDenied,
  gpsPermissionDeniedForever,
  geolocationIP,
}

class AppException implements Exception {
  final AppExceptionType type;
  final Object? exception;
  final String? message;

  AppException({
    required this.type,
    this.exception,
    this.message,
  });
}
