// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericErrorResponse _$GenericErrorResponseFromJson(
        Map<String, dynamic> json) =>
    GenericErrorResponse(
      errors: json['message'] as String?,
      errorCode: json['errorCode'] as String?,
      status: json['status'] as bool?,
      statusCode: json['code'] as int?,
    );

Map<String, dynamic> _$GenericErrorResponseToJson(
        GenericErrorResponse instance) =>
    <String, dynamic>{
      'message': instance.errors,
      'errorCode': instance.errorCode,
      'status': instance.status,
      'code': instance.statusCode,
    };
