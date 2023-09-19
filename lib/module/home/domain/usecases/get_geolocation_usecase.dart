import '../repository/geolocation_repository.dart';

class GetGeolocationUseCase {
  final GeolocationRepository repository;

  GetGeolocationUseCase({
    required this.repository,
  });

  Future<({double latitude, double longitude})> call() async {
    return await repository.getRemoteGeolocationIP();
  }
}
