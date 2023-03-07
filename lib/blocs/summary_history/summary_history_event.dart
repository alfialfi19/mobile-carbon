part of 'summary_history_bloc.dart';

abstract class SummaryHistoryEvent extends Equatable {}

class LoadSummaryHistory extends SummaryHistoryEvent {
  final int? page;
  final String? type;

  LoadSummaryHistory(this.page, this.type);

  @override
  List<Object?> get props => [
        page,
        type,
      ];
}
