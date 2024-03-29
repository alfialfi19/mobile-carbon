import 'package:get_it/get_it.dart';

import '../api/api.dart';
import '../commons/commons.dart';

final locator = GetIt.instance;

// void unSetupLocator() {
//   locator.unregister<PrefHelper>();
// }

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
      () => ArticleApi(locator<BaseDioClient>().dio),
    )
    ..registerLazySingleton(
      () => AuthApi(locator<BaseDioClient>().dio),
    )
    ..registerLazySingleton(
      () => CommentApi(locator<BaseDioClient>().dio),
    )
    ..registerLazySingleton(
      () => DonationApi(locator<BaseDioClient>().dio),
    )
    ..registerLazySingleton(
      () => EcoActivityApi(locator<BaseDioClient>().dio),
    )
    ..registerLazySingleton(
      () => EmisiLogApi(locator<BaseDioClient>().dio),
    )
    ..registerLazySingleton(
      () => MasterApi(locator<BaseDioClient>().dio),
    )
    ..registerLazySingleton(
      () => NotificationApi(locator<BaseDioClient>().dio),
    )
    ..registerLazySingleton(
      () => MediaApi(locator<BaseDioClient>().dio),
    )
    ..registerLazySingleton(
      () => SummaryApi(locator<BaseDioClient>().dio),
    );
}
