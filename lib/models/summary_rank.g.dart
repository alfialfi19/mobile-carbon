// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_rank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryRank _$SummaryRankFromJson(Map<String, dynamic> json) => SummaryRank(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => RankData.fromJson(e as Map<String, dynamic>))
          .toList(),
      listSelected: json['list_selected'] == null
          ? null
          : RankData.fromJson(json['list_selected'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SummaryRankToJson(SummaryRank instance) =>
    <String, dynamic>{
      'list': instance.list,
      'list_selected': instance.listSelected,
    };

RankData _$RankDataFromJson(Map<String, dynamic> json) => RankData(
      id: json['id'] as String?,
      fullName: json['full_name'] as String?,
      file: json['file'] as String?,
      totalPoint: json['total_point'] as String?,
      rank: json['rank'] as String?,
    );

Map<String, dynamic> _$RankDataToJson(RankData instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'file': instance.file,
      'total_point': instance.totalPoint,
      'rank': instance.rank,
    };
