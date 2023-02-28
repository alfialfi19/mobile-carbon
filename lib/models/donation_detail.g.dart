// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonationDetail _$DonationDetailFromJson(Map<String, dynamic> json) =>
    DonationDetail(
      id: json['id'] as String?,
      slug: json['slug'] as String?,
      title: json['title'] as String?,
      location: json['location'] as String?,
      activityAt: json['activity_at'] as String?,
      contact: json['contact'] as String?,
      deadlineAt: json['deadline_at'] as String?,
      url: json['url'] as String?,
      writer: json['writer'] as String?,
      writerName: json['writer_name'] as String?,
      desc: json['desc'] as String?,
      totalViews: json['total_views'] as String?,
      file: json['file'] as List<dynamic>?,
      status: json['status'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      processedBy: json['processed_by'] as String?,
      processedAt: json['processed_at'] as String?,
      writerImg: json['writer_img'] as String?,
    );

Map<String, dynamic> _$DonationDetailToJson(DonationDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'location': instance.location,
      'activity_at': instance.activityAt,
      'contact': instance.contact,
      'deadline_at': instance.deadlineAt,
      'url': instance.url,
      'writer': instance.writer,
      'writer_name': instance.writerName,
      'desc': instance.desc,
      'total_views': instance.totalViews,
      'file': instance.file,
      'status': instance.status,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'processed_by': instance.processedBy,
      'processed_at': instance.processedAt,
      'writer_img': instance.writerImg,
    };
