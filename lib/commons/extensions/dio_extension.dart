import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../models/models.dart';
import '../commons.dart';

extension ExtractDioError on DioError {
  GenericErrorResponse toGenericError() {
    if (error is SocketException) {
      return GenericErrorResponse(
        errors: message,
        status: ErrorStatusMessage.connectionTimeout,
        statusCode: ErrorStatusCode.connectionTimeout,
      );
    } else if (response == null) {
      return GenericErrorResponse(
        errors: message,
        status: ErrorStatusMessage.unknownError,
        statusCode: ErrorStatusCode.unknown,
      );
    } else {
      if (response!.statusCode! < HttpStatus.internalServerError) {
        try {
          final errorJson = jsonDecode(response.toString());

          /// to enter 'error' object from errorJson
          final sanitizeErrorJson = errorJson['error'];

          sanitizeErrorJson['statusCode'] = response!.statusCode;

          return GenericErrorResponse.fromJson(sanitizeErrorJson);
        } on Exception {
          return GenericErrorResponse(
            errors: message,
            status: response!.statusMessage,
            statusCode: response!.statusCode,
          );
        }
      }

      return GenericErrorResponse(
        errors: message,
        status: response!.statusMessage,
        statusCode: response!.statusCode,
      );
    }
  }
}
