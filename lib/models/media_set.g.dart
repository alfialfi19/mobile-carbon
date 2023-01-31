// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaSet _$MediaSetFromJson(Map<String, dynamic> json) => MediaSet(
      media: json['media'] == null
          ? null
          : Media.fromJson(json['media'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MediaSetToJson(MediaSet instance) => <String, dynamic>{
      'media': instance.media,
    };

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      id: json['id'] as String?,
      url: json['url'] as String?,
      filetype: json['filetype'] as String?,
      filename: json['filename'] as String?,
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'filetype': instance.filetype,
      'filename': instance.filename,
    };
