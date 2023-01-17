import 'commons/commons.dart';

Flavor? appFlavor;

bool get isStaging => appFlavor == Flavor.staging;
bool get isProd => appFlavor == Flavor.prod;
