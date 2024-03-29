import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/api/api.dart';
import 'package:mobile_carbon/repositories/emisi_log_repository.dart';
import 'package:mobile_carbon/repositories/repositories.dart';

import '../commons/commons.dart';
import 'service_locator.dart';

final repositoryProviders = [
  RepositoryProvider<ArticleRepository>(
    create: (context) => ArticleRepository(
      locator<ArticleApi>(),
    ),
  ),
  RepositoryProvider<AuthRepository>(
    create: (context) => AuthRepository(
      locator<AuthApi>(),
      locator<PrefHelper>(),
    ),
  ),
  RepositoryProvider<CommentRepository>(
    create: (context) => CommentRepository(
      locator<CommentApi>(),
    ),
  ),
  RepositoryProvider<DonationRepository>(
    create: (context) => DonationRepository(
      locator<DonationApi>(),
    ),
  ),
  RepositoryProvider<EmisiLogRepository>(
    create: (context) => EmisiLogRepository(
      locator<EmisiLogApi>(),
    ),
  ),
  RepositoryProvider<EcoActivityRepository>(
    create: (context) => EcoActivityRepository(
      locator<EcoActivityApi>(),
    ),
  ),
  RepositoryProvider<MasterRepository>(
    create: (context) => MasterRepository(
      locator<MasterApi>(),
    ),
  ),
  RepositoryProvider<NotificationRepository>(
    create: (context) => NotificationRepository(
      locator<NotificationApi>(),
    ),
  ),
  RepositoryProvider<MediaRepository>(
    create: (context) => MediaRepository(
      locator<MediaApi>(),
    ),
  ),
  RepositoryProvider<SummaryRepository>(
    create: (context) => SummaryRepository(
      locator<SummaryApi>(),
    ),
  ),
];
