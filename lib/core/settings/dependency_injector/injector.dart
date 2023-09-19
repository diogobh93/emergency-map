abstract class Injector {
  T getInstance<T extends Object>({String instanceName});

  void registerLazySingleton<T extends Object>({
    String? instanceName,
    required T instance,
  });
}
