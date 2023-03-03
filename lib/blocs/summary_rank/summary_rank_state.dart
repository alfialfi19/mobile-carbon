part of 'summary_rank_bloc.dart';

abstract class SummaryRankState extends BlocState {
  const SummaryRankState({
    super.statusCode,
    super.message,
    super.errorCode,
  });
}

class SummaryRankInitial extends SummaryRankState {}

class SummaryRankLoading extends SummaryRankState {}

class SummaryRankLoaded extends SummaryRankState {
  final SummaryRank summaryRank;

  const SummaryRankLoaded(this.summaryRank);
}

class SummaryRankError extends SummaryRankState {
  final GenericErrorResponse errorResponse;

  const SummaryRankError(this.errorResponse);
}
