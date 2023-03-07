import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary_history.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SummaryHistory extends Equatable {
  final String? totalPoint;
  final String? result;
  final String? rank;

  const SummaryHistory({
    this.totalPoint,
    this.result,
    this.rank,
  });

  Map<String, dynamic> toJson() => _$SummaryHistoryToJson(this);

  factory SummaryHistory.fromJson(Map<String, dynamic> json) =>
      _$SummaryHistoryFromJson(json);

  @override
  List<Object?> get props => [
        totalPoint,
        result,
        rank,
      ];
}
