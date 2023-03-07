import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary_emisi_log.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SummaryEmisiLog extends Equatable {
  final List<EmisiLogs>? list;
  final EmisiLogDetail? detail;

  const SummaryEmisiLog({
    this.list,
    this.detail,
  });

  Map<String, dynamic> toJson() => _$SummaryEmisiLogToJson(this);

  factory SummaryEmisiLog.fromJson(Map<String, dynamic> json) =>
      _$SummaryEmisiLogFromJson(json);

  @override
  List<Object?> get props => [
        list,
        detail,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class EmisiLogs extends Equatable {
  final String? id;
  final String? opt;
  final String? unit;
  final String? file;
  final String? val;
  final String? result;

  const EmisiLogs({
    this.id,
    this.opt,
    this.unit,
    this.file,
    this.val,
    this.result,
  });

  Map<String, dynamic> toJson() => _$EmisiLogsToJson(this);

  factory EmisiLogs.fromJson(Map<String, dynamic> json) =>
      _$EmisiLogsFromJson(json);

  @override
  List<Object?> get props => [
        id,
        opt,
        unit,
        file,
        val,
        result,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class EmisiLogDetail extends Equatable {
  final String? percentage;
  final String? totalCarbon;
  final String? limitCarbon;

  const EmisiLogDetail({
    this.percentage,
    this.totalCarbon,
    this.limitCarbon,
  });

  Map<String, dynamic> toJson() => _$EmisiLogDetailToJson(this);

  factory EmisiLogDetail.fromJson(Map<String, dynamic> json) =>
      _$EmisiLogDetailFromJson(json);

  @override
  List<Object?> get props => [
        percentage,
        totalCarbon,
        limitCarbon,
      ];
}
