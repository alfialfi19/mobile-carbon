// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericErrorResponse _$GenericErrorResponseFromJson(
        Map<String, dynamic> json) =>
    GenericErrorResponse(
      errors: json['message'] as String?,
      errorCode: json['error_code'] as String?,
      status: json['status'] as String?,
      statusCode: json['statusCode'] as int?,
    );

Map<String, dynamic> _$GenericErrorResponseToJson(
        GenericErrorResponse instance) =>
    <String, dynamic>{
      'message': instance.errors,
      'error_code': instance.errorCode,
      'status': instance.status,
      'statusCode': instance.statusCode,
    };
