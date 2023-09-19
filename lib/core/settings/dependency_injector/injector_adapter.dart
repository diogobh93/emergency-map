import 'package:emergency_map/core/error/app_exception.dart';
import 'package:get_it/get_it.dart';
import 'injector.dart';

class InjectorAdapter implements Injector {
  final GetIt getIt;

  InjectorAdapter._({required this.getIt});
  static final InjectorAdapter _singleton = InjectorAdapter._(getIt: GetIt.I);
  factory InjectorAdapter() => _singleton;

  @override
  T getInstance<T extends Object>({String? instanceName}) {
    try {
      return getIt.get<T>(instanceName: instanceName);
    } catch (e) {
      throw AppException(
        type: AppExceptionType.dependencyInjector,
        exception: e,
      );
    }
  }

  @override
  void registerLazySingleton<T extends Object>(
      {required T instance, String? instanceName}) {
    try {
      getIt.registerLazySingleton<T>(
        () => instance,
        instanceName: instanceName,
      );
    } catch (e) {
      throw AppException(
        type: AppExceptionType.dependencyInjector,
        exception: e,
      );
    }
  }
}
