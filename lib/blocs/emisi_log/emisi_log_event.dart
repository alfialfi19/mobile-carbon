part of 'emisi_log_bloc.dart';

abstract class EmisiLogEvent extends Equatable {}

class LoadEmisiLog extends EmisiLogEvent {
  final int? page;

  LoadEmisiLog(this.page);

  @override
  List<Object?> get props => [
        page,
      ];
}
