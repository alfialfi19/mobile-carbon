part of 'emisi_log_bloc.dart';

abstract class EmisiLogState extends BlocState {
  const EmisiLogState({
    super.statusCode,
    super.message,
    super.errorCode,
  });
}

class EmisiLogInitial extends EmisiLogState {}

class EmisiLogLoading extends EmisiLogState {}

class EmisiLogLoadingPaging extends EmisiLogState {}

class EmisiLogLoaded extends EmisiLogState {
  final List<EmisiLog> emisiLogList;

  const EmisiLogLoaded(this.emisiLogList);
}

class EmisiLogEmpty extends EmisiLogState {}

class EmisiLogError extends EmisiLogState {
  final GenericErrorResponse errorResponse;

  const EmisiLogError(this.errorResponse);
}

class StoreEmisiLogLoading extends EmisiLogState {}

class StoreEmisiLogSuccess extends EmisiLogState {}

class StoreEmisiLogError extends EmisiLogState {
  final GenericErrorResponse errorResponse;

  const StoreEmisiLogError(this.errorResponse);
}
