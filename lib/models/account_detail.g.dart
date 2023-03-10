// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDetail _$AccountDetailFromJson(Map<String, dynamic> json) =>
    AccountDetail(
      jwtToken: json['jwt_token'] as String?,
      fcmToken: json['fcm_token'] as String?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      level: json['level'] as String?,
      totalPoint1: json['total_point_1'] as String?,
      totalPoint2: json['total_point_2'] as String?,
      totalPoint3: json['total_point_3'] as String?,
      status: json['status'] as String?,
      file: json['file'] as String?,
      role: json['role'] as String?,
      roleNama: json['role_nama'] as String?,
      levelDetail: json['level_detail'] == null
          ? null
          : LevelDetail.fromJson(json['level_detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountDetailToJson(AccountDetail instance) =>
    <String, dynamic>{
      'jwt_token': instance.jwtToken,
      'fcm_token': instance.fcmToken,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'level': instance.level,
      'total_point1': instance.totalPoint1,
      'total_point2': instance.totalPoint2,
      'total_point3': instance.totalPoint3,
      'status': instance.status,
      'file': instance.file,
      'role': instance.role,
      'role_nama': instance.roleNama,
      'level_detail': instance.levelDetail,
    };

LevelDetail _$LevelDetailFromJson(Map<String, dynamic> json) => LevelDetail(
      level: json['level'] as String?,
      participant: json['participant'] as String?,
      participantList: (json['participant_list'] as List<dynamic>?)
              ?.map((e) => Participant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      nowAt: json['now_at'] as String?,
      deadlineAt: json['deadline_at'] as String?,
      deadlineDay: json['deadline_day'] as int?,
    );

Map<String, dynamic> _$LevelDetailToJson(LevelDetail instance) =>
    <String, dynamic>{
      'level': instance.level,
      'participant': instance.participant,
      'participant_list': instance.participantList,
      'now_at': instance.nowAt,
      'deadline_at': instance.deadlineAt,
      'deadline_day': instance.deadlineDay,
    };

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      fullName: json['full_name'] as String?,
      file: json['file'] as String?,
    );

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'file': instance.file,
    };
