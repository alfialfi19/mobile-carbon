import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_error_response.g.dart';

@JsonSerializable()
class GenericErrorResponse extends Equatable implements Exception {
  @JsonKey(name: 'message')
  final String? errors;
  final String? errorCode;
  final bool? status;
  @JsonKey(name: 'code')
  final int? statusCode;

  const GenericErrorResponse({
    this.errors,
    this.errorCode,
    this.status,
    this.statusCode,
  });

  factory GenericErrorResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      return const GenericErrorResponse();
    } else {
      return _$GenericErrorResponseFromJson(json);
    }
  }

  Map<String, dynamic> toJson() => _$GenericErrorResponseToJson(this);

  @override
  String toString() {
    return errors ?? "";
  }

  @override
  List<Object?> get props => [errors, errorCode, status, statusCode];
}
