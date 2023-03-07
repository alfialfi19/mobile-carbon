// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emisi_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmisiLog _$EmisiLogFromJson(Map<String, dynamic> json) => EmisiLog(
      id: json['id'] as String?,
      writer: json['writer'] as String?,
      writerName: json['writer_name'] as String?,
      category: json['category'] as String?,
      categoryName: json['category_name'] as String?,
      categorySub: json['category_sub'] as String?,
      categorySubName: json['category_sub_name'] as String?,
      val: json['val'] as String?,
      unit: json['unit'] as String?,
      formula: json['formula'] as String?,
      result: json['result'] as String?,
      totalPoint: json['total_point'] as String?,
      file: json['file'] as String?,
      status: json['status'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      categoryImg: json['category_img'] as String?,
    );

Map<String, dynamic> _$EmisiLogToJson(EmisiLog instance) => <String, dynamic>{
      'id': instance.id,
      'writer': instance.writer,
      'writer_name': instance.writerName,
      'category': instance.category,
      'category_name': instance.categoryName,
      'category_sub': instance.categorySub,
      'category_sub_name': instance.categorySubName,
      'val': instance.val,
      'unit': instance.unit,
      'formula': instance.formula,
      'result': instance.result,
      'total_point': instance.totalPoint,
      'file': instance.file,
      'status': instance.status,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'category_img': instance.categoryImg,
    };
