part of 'eco_activity_bloc.dart';

abstract class EcoActivityState extends BlocState {
  const EcoActivityState({
    super.statusCode,
    super.message,
    super.errorCode,
  });
}

class EcoActivityInitial extends EcoActivityState {}

class ListEcoActivityLoading extends EcoActivityState {}

class ListEcoActivityEmpty extends EcoActivityState {}

class ListEcoActivityLoaded extends EcoActivityState {
  final List<ArticleDetail> ecoActivityList;

  const ListEcoActivityLoaded(this.ecoActivityList);
}

class ListEcoActivityError extends EcoActivityState {
  final GenericErrorResponse errorResponse;

  const ListEcoActivityError(this.errorResponse);
}
