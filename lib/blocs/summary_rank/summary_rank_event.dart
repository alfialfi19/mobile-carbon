part of 'summary_rank_bloc.dart';

abstract class SummaryRankEvent extends Equatable {}

class LoadSummaryRank extends SummaryRankEvent {
  final int? page;
  final String? type;

  LoadSummaryRank(this.page, this.type);

  @override
  List<Object?> get props => [
        page,
        type,
      ];
}
