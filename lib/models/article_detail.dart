import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ArticleDetail extends Equatable {
  final String? id;
  final String? slug;
  final String? title;
  final String? category;
  final String? categoryName;
  final String? writer;
  final String? writerName;
  final String? desc;
  final String? totalViews;
  final String? totalComments;
  final String? totalPoint;
  final List? file;
  final String? status;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final String? processedBy;
  final String? processedAt;
  final String? writerImg;
  final String? categoryImg;

  const ArticleDetail({
    this.id,
    this.slug,
    this.title,
    this.category,
    this.categoryName,
    this.writer,
    this.writerName,
    this.desc,
    this.totalViews,
    this.totalComments,
    this.totalPoint,
    this.file,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.processedBy,
    this.processedAt,
    this.writerImg,
    this.categoryImg,
  });

  Map<String, dynamic> toJson() => _$ArticleDetailToJson(this);

  factory ArticleDetail.fromJson(Map<String, dynamic> json) =>
      _$ArticleDetailFromJson(json);

  @override
  List<Object?> get props => [
        id,
        slug,
        title,
        category,
        categoryName,
        writer,
        writerName,
        desc,
        totalViews,
        totalComments,
        totalPoint,
        file,
        status,
        createdBy,
        createdAt,
        updatedAt,
        processedBy,
        processedAt,
        writerImg,
        categoryImg,
      ];
}
