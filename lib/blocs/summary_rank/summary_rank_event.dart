part of 'summary_rank_bloc.dart';

abstract class SummaryRankEvent extends Equatable {}

class LoadSummaryRank extends SummaryRankEvent {
  final int? page;
  final String? type;
  final List<RankData>? currentData;

  LoadSummaryRank({
    this.page,
    this.type,
    this.currentData,
  });

  @override
  List<Object?> get props => [
        page,
        type,
        currentData,
      ];
}
