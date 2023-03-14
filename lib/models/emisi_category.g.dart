// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emisi_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmisiCategory _$EmisiCategoryFromJson(Map<String, dynamic> json) =>
    EmisiCategory(
      id: json['id'] as String?,
      opt: json['opt'] as String?,
      file: json['file'] as String?,
      idCategory: json['id_category'] as String?,
      category: json['category'] as String?,
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$EmisiCategoryToJson(EmisiCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'opt': instance.opt,
      'file': instance.file,
      'id_category': instance.idCategory,
      'category': instance.category,
      'unit': instance.unit,
    };
