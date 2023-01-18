import 'dart:io';

class ErrorStatusCode {
  static const int unknown = -1;
  static const int connectionTimeout = -2;
}

class ErrorStatusMessage {
  static const String unknownError = 'unknown_error';
  static const String connectionTimeout = 'connection_timeout';
  static const String unauthorizedKong =
      'HttpException: Failed to parse header value';
}

class ErrorCodePermission {
  static const String cameraDenied = 'camera_access_denied';
  static const String photosDenied = 'photo_access_denied';
  static const String storageDenied = 'read_external_storage_denied';
}

bool checkConnectionError(int? statusCode) {
  return statusCode == HttpStatus.requestTimeout || //408
      statusCode == ErrorStatusCode.connectionTimeout; //-2 custom status code
}
