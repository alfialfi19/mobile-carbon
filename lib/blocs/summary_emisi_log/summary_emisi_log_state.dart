part of 'summary_emisi_log_bloc.dart';

abstract class SummaryEmisiLogState extends BlocState {
  const SummaryEmisiLogState({
    super.statusCode,
    super.message,
    super.errorCode,
  });
}

class SummaryEmisiLogInitial extends SummaryEmisiLogState {}

class SummaryEmisiLogLoading extends SummaryEmisiLogState {}

class SummaryEmisiLogLoaded extends SummaryEmisiLogState {
  final SummaryEmisiLog summaryEmisiLog;

  const SummaryEmisiLogLoaded(this.summaryEmisiLog);
}

class SummaryEmisiLogError extends SummaryEmisiLogState {
  final GenericErrorResponse errorResponse;

  const SummaryEmisiLogError(this.errorResponse);
}
