import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emergency_map/module/home/domain/usecases/get_device_gps_enabled_usecase.dart';
import 'package:geolocator/geolocator.dart';

import '../core/settings/settings.dart';
import '../module/home/home.dart';

class AppDependencies {
  static final Injector _injector = InjectorAdapter();

  void registerAppDependencies() {
    _registerHttpClient();
    _registerGeolocationIP();
    _registerDeviceConnectivity();
    _registerDeviceGeolocation();
    _registerController();
  }

  void _registerHttpClient() {
    _injector.registerLazySingleton<HTTP>(
      instance: DioClientAdapter(
        dio: getDioInstance(),
      ),
    );
  }

  void _registerGeolocationIP() {
    // Datasource
    _injector.registerLazySingleton<GeolocationDataSource>(
      instance: GeolocationRemoteDatasourceImpl(
        client: _injector.getInstance<HTTP>(),
      ),
    );

    // Infra Repository
    _injector.registerLazySingleton<GeolocationRepositoryImpl>(
      instance: GeolocationRepositoryImpl(
        datasource: _injector.getInstance<GeolocationDataSource>(),
      ),
    );

    // Domain Repository
    _injector.registerLazySingleton<GeolocationRepository>(
      instance: _injector.getInstance<GeolocationRepositoryImpl>(),
    );

    // Usecases
    _injector.registerLazySingleton<GetGeolocationUseCase>(
      instance: GetGeolocationUseCase(
        repository: _injector.getInstance<GeolocationRepository>(),
      ),
    );
  }

  void _registerDeviceConnectivity() {
    // Package Connectivity
    _injector.registerLazySingleton<Connectivity>(
      instance: Connectivity(),
    );

    // Driver
    _injector.registerLazySingleton<DeviceConnectivityDriver>(
      instance: ConnectivityLocalDriverImpl(
        connectivity: _injector.getInstance<Connectivity>(),
      ),
    );

    // Infra Service
    _injector.registerLazySingleton<DeviceConnectivityServiceImpl>(
      instance: DeviceConnectivityServiceImpl(
        driver: _injector.getInstance<DeviceConnectivityDriver>(),
      ),
    );
    // Domain Service
    _injector.registerLazySingleton<DeviceConnectivityService>(
      instance: _injector.getInstance<DeviceConnectivityServiceImpl>(),
    );

    // Usecases
    _injector.registerLazySingleton<GetDeviceConnectivityUseCase>(
      instance: GetDeviceConnectivityUseCase(
        service: _injector.getInstance<DeviceConnectivityService>(),
      ),
    );
  }

  void _registerDeviceGeolocation() {
    // Package Geolocator
    _injector.registerLazySingleton<Geolocator>(
      instance: Geolocator(),
    );

    // Driver
    _injector.registerLazySingleton<DeviceGeolocationDriver>(
      instance: GeolocationLocalDriverImpl(
        geolocator: _injector.getInstance<Geolocator>(),
      ),
    );

    // Infra Service
    _injector.registerLazySingleton<DeviceGeolocationServiceImpl>(
      instance: DeviceGeolocationServiceImpl(
        driver: _injector.getInstance<DeviceGeolocationDriver>(),
      ),
    );

    // Domain Service
    _injector.registerLazySingleton<DeviceGeolocationService>(
      instance: _injector.getInstance<DeviceGeolocationServiceImpl>(),
    );

    // Usecase DeviceGeolocation
    _injector.registerLazySingleton<GetDeviceGeolocationUseCase>(
      instance: GetDeviceGeolocationUseCase(
        service: _injector.getInstance<DeviceGeolocationService>(),
      ),
    );

    // Usecase DeviceGpsEnabled
    _injector.registerLazySingleton<GetDeviceGpsEnabledUseCase>(
      instance: GetDeviceGpsEnabledUseCase(
        service: _injector.getInstance<DeviceGeolocationService>(),
      ),
    );
  }

  void _registerController() {
    _injector.registerLazySingleton<HomeController>(
      instance: HomeController(
        getDeviceConnectivityUseCase:
            _injector.getInstance<GetDeviceConnectivityUseCase>(),
        getDeviceGeolocationUseCase:
            _injector.getInstance<GetDeviceGeolocationUseCase>(),
        getDeviceGpsEnabledUseCase:
            _injector.getInstance<GetDeviceGpsEnabledUseCase>(),
        getGeolocationUseCase: _injector.getInstance<GetGeolocationUseCase>(),
      ),
    );
  }
}
