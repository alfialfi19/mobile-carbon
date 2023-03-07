// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comments _$CommentsFromJson(Map<String, dynamic> json) => Comments(
      id: json['id'] as String?,
      idParent: json['id_parent'] as String?,
      idChild: json['id_child'] as String?,
      article: json['article'] as String?,
      articleName: json['article_name'] as String?,
      writer: json['writer'] as String?,
      writerName: json['writer_name'] as String?,
      receiver: json['receiver'] as String?,
      receiverName: json['receiver_name'] as String?,
      desc: json['desc'] as String?,
      file: json['file'] as String?,
      status: json['status'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      processedBy: json['processed_by'] as String?,
      processedAt: json['processed_at'] as String?,
      item: (json['item'] as List<dynamic>?)
          ?.map((e) => CommentsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      'id': instance.id,
      'id_parent': instance.idParent,
      'id_child': instance.idChild,
      'article': instance.article,
      'article_name': instance.articleName,
      'writer': instance.writer,
      'writer_name': instance.writerName,
      'receiver': instance.receiver,
      'receiver_name': instance.receiverName,
      'desc': instance.desc,
      'file': instance.file,
      'status': instance.status,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'processed_by': instance.processedBy,
      'processed_at': instance.processedAt,
      'item': instance.item,
    };

CommentsItem _$CommentsItemFromJson(Map<String, dynamic> json) => CommentsItem(
      id: json['id'] as String?,
      idParent: json['id_parent'] as String?,
      idChild: json['id_child'] as String?,
      article: json['article'] as String?,
      articleName: json['article_name'] as String?,
      writer: json['writer'] as String?,
      writerName: json['writer_name'] as String?,
      receiver: json['receiver'] as String?,
      receiverName: json['receiver_name'] as String?,
      desc: json['desc'] as String?,
      file: json['file'] as String?,
      status: json['status'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      processedBy: json['processed_by'] as String?,
      processedAt: json['processed_at'] as String?,
    );

Map<String, dynamic> _$CommentsItemToJson(CommentsItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_parent': instance.idParent,
      'id_child': instance.idChild,
      'article': instance.article,
      'article_name': instance.articleName,
      'writer': instance.writer,
      'writer_name': instance.writerName,
      'receiver': instance.receiver,
      'receiver_name': instance.receiverName,
      'desc': instance.desc,
      'file': instance.file,
      'status': instance.status,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'processed_by': instance.processedBy,
      'processed_at': instance.processedAt,
    };
