// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_emisi_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryEmisiLog _$SummaryEmisiLogFromJson(Map<String, dynamic> json) =>
    SummaryEmisiLog(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => EmisiLogs.fromJson(e as Map<String, dynamic>))
          .toList(),
      detail: json['detail'] == null
          ? null
          : EmisiLogDetail.fromJson(json['detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SummaryEmisiLogToJson(SummaryEmisiLog instance) =>
    <String, dynamic>{
      'list': instance.list,
      'detail': instance.detail,
    };

EmisiLogs _$EmisiLogsFromJson(Map<String, dynamic> json) => EmisiLogs(
      id: json['id'] as String?,
      opt: json['opt'] as String?,
      unit: json['unit'] as String?,
      file: json['file'] as String?,
      val: json['val'] as String?,
      result: json['result'] as String?,
    );

Map<String, dynamic> _$EmisiLogsToJson(EmisiLogs instance) => <String, dynamic>{
      'id': instance.id,
      'opt': instance.opt,
      'unit': instance.unit,
      'file': instance.file,
      'val': instance.val,
      'result': instance.result,
    };

EmisiLogDetail _$EmisiLogDetailFromJson(Map<String, dynamic> json) =>
    EmisiLogDetail(
      percentage: json['percentage'] as String?,
      totalCarbon: json['total_carbon'] as String?,
      limitCarbon: json['limit_carbon'] as String?,
    );

Map<String, dynamic> _$EmisiLogDetailToJson(EmisiLogDetail instance) =>
    <String, dynamic>{
      'percentage': instance.percentage,
      'total_carbon': instance.totalCarbon,
      'limit_carbon': instance.limitCarbon,
    };
