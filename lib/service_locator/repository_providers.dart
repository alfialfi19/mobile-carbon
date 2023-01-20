import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/api/api.dart';
import 'package:mobile_carbon/repositories/repositories.dart';

import '../commons/commons.dart';
import 'service_locator.dart';

final repositoryProviders = [
  RepositoryProvider<SignInRepository>(
    create: (context) => SignInRepository(
      locator<SignInApi>(),
      locator<PrefHelper>(),
    ),
  ),
];