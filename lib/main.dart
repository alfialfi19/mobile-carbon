import 'package:flutter/material.dart';
import 'package:mobile_carbon/app_config.dart';
import 'package:mobile_carbon/main_delegate.dart';
import 'package:mobile_carbon/my_app.dart';

import 'commons/commons.dart';

Future<void> main() async {
  appFlavor = Flavor.staging;

  mainDelegate();

  // Run App
  return runApp(
    const MyApp(),
  );
}
