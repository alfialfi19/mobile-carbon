import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'emisi_log.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EmisiLog extends Equatable {
  final String? id;
  final String? writer;
  final String? writerName;
  final String? category;
  final String? categoryName;
  final String? categorySub;
  final String? categorySubName;
  final String? val;
  final String? unit;
  final String? formula;
  final String? result;
  final String? totalPoint;
  final String? file;
  final String? status;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final String? categoryImg;

  const EmisiLog({
    this.id,
    this.writer,
    this.writerName,
    this.category,
    this.categoryName,
    this.categorySub,
    this.categorySubName,
    this.val,
    this.unit,
    this.formula,
    this.result,
    this.totalPoint,
    this.file,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.categoryImg,
  });

  Map<String, dynamic> toJson() => _$EmisiLogToJson(this);

  factory EmisiLog.fromJson(Map<String, dynamic> json) =>
      _$EmisiLogFromJson(json);

  @override
  List<Object?> get props => [
        id,
        writer,
        writerName,
        category,
        categoryName,
        categorySub,
        categorySubName,
        val,
        unit,
        formula,
        result,
        totalPoint,
        file,
        status,
        createdBy,
        createdAt,
        updatedAt,
        categoryImg,
      ];
}
