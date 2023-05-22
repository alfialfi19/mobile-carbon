import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/route_factory.dart';
import 'package:mobile_carbon/routes.dart';

import 'commons/commons.dart';
import 'service_locator/repository_providers.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: repositoryProviders,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: Routes.splash,
        title: "Daur Karbon",
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => getPageByName(
              settings.name,
              nonNullable: true,
            )!,
            settings: settings,
          );
        },
      ),
    );
  }
}
