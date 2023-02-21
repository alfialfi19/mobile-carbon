import 'package:get_it/get_it.dart';

import '../api/api.dart';
import '../commons/commons.dart';

final locator = GetIt.instance;

void unSetupLocator() {
  locator.unregister<PrefHelper>();
}

void setupLocator() {
  // local
  locator
    ..registerLazySingleton(
      PrefHelper.new,
    )

    // network
    ..registerLazySingleton(
      () => BaseDioClient(
        flavor: GlobalService().usageFlavor,
        prefHelper: locator<PrefHelper>(),
      ),
    )
    ..registerLazySingleton(
      () => MediaApi(locator<BaseDioClient>().dio),
    )
    ..registerLazySingleton(
      () => AuthApi(locator<BaseDioClient>().dio),
    );
}
