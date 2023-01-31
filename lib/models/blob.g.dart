// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blob.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blob _$BlobFromJson(Map<String, dynamic> json) => Blob(
      id: json['id'] as String?,
      url: json['url'] as String?,
      fileName: json['fileName'] as String?,
      filePath: json['filePath'] as String?,
      fileType: json['fileType'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$BlobToJson(Blob instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'fileName': instance.fileName,
      'filePath': instance.filePath,
      'fileType': instance.fileType,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
