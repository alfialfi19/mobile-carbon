// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDetail _$ArticleDetailFromJson(Map<String, dynamic> json) =>
    ArticleDetail(
      id: json['id'] as String?,
      slug: json['slug'] as String?,
      title: json['title'] as String?,
      category: json['category'] as String?,
      categoryName: json['category_name'] as String?,
      writer: json['writer'] as String?,
      writerName: json['writer_name'] as String?,
      desc: json['desc'] as String?,
      totalViews: json['total_views'] as String?,
      totalComments: json['total_comments'] as String?,
      totalPoint: json['total_point'] as String?,
      file: json['file'] as List<dynamic>?,
      status: json['status'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      processedBy: json['processed_by'] as String?,
      processedAt: json['processed_at'] as String?,
      writerImg: json['writer_img'] as String?,
      categoryImg: json['category_img'] as String?,
    );

Map<String, dynamic> _$ArticleDetailToJson(ArticleDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'category': instance.category,
      'category_name': instance.categoryName,
      'writer': instance.writer,
      'writer_name': instance.writerName,
      'desc': instance.desc,
      'total_views': instance.totalViews,
      'total_comments': instance.totalComments,
      'total_point': instance.totalPoint,
      'file': instance.file,
      'status': instance.status,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'processed_by': instance.processedBy,
      'processed_at': instance.processedAt,
      'writer_img': instance.writerImg,
      'category_img': instance.categoryImg,
    };
