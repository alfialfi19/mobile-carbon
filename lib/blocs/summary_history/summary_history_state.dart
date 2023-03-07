part of 'summary_history_bloc.dart';

abstract class SummaryHistoryState extends BlocState {
  const SummaryHistoryState({
    super.statusCode,
    super.message,
    super.errorCode,
  });
}

class SummaryHistoryInitial extends SummaryHistoryState {}

class SummaryHistoryLoading extends SummaryHistoryState {}

class SummaryHistoryLoaded extends SummaryHistoryState {
  final SummaryHistory summaryHistory;

  const SummaryHistoryLoaded(this.summaryHistory);
}

class SummaryHistoryError extends SummaryHistoryState {
  final GenericErrorResponse errorResponse;

  const SummaryHistoryError(this.errorResponse);
}
