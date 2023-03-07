// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryHistory _$SummaryHistoryFromJson(Map<String, dynamic> json) =>
    SummaryHistory(
      totalPoint: json['total_point'] as String?,
      result: json['result'] as String?,
      rank: json['rank'] as String?,
    );

Map<String, dynamic> _$SummaryHistoryToJson(SummaryHistory instance) =>
    <String, dynamic>{
      'total_point': instance.totalPoint,
      'result': instance.result,
      'rank': instance.rank,
    };
