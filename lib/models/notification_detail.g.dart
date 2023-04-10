// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDetail _$NotificationDetailFromJson(Map<String, dynamic> json) =>
    NotificationDetail(
      id: json['id'] as String?,
      type: json['type'] as String?,
      idArticle: json['id_article'] as String?,
      idParent: json['id_parent'] as String?,
      idChild: json['id_child'] as String?,
      idReceiver: json['id_receiver'] as String?,
      title: json['title'] as String?,
      desc: json['desc'] as String?,
      file: json['file'] as String?,
      status: json['status'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$NotificationDetailToJson(NotificationDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'id_article': instance.idArticle,
      'id_parent': instance.idParent,
      'id_child': instance.idChild,
      'id_receiver': instance.idReceiver,
      'title': instance.title,
      'desc': instance.desc,
      'file': instance.file,
      'status': instance.status,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
