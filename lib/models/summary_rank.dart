import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary_rank.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SummaryRank extends Equatable {
  final List<RankData>? list;
  final RankData? listSelected;

  const SummaryRank({
    this.list,
    this.listSelected,
  });

  Map<String, dynamic> toJson() => _$SummaryRankToJson(this);

  factory SummaryRank.fromJson(Map<String, dynamic> json) =>
      _$SummaryRankFromJson(json);

  @override
  List<Object?> get props => [
        list,
        listSelected,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RankData extends Equatable {
  final String? id;
  final String? fullName;
  final String? file;
  final String? totalPoint;
  final String? rank;

  const RankData({
    this.id,
    this.fullName,
    this.file,
    this.totalPoint,
    this.rank,
  });

  Map<String, dynamic> toJson() => _$RankDataToJson(this);

  factory RankData.fromJson(Map<String, dynamic> json) =>
      _$RankDataFromJson(json);

  @override
  List<Object?> get props => [
        id,
        fullName,
        file,
        totalPoint,
        rank,
      ];
}
