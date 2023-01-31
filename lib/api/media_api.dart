import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../commons/commons.dart';
import '../models/models.dart';

class MediaApi {
  static const mockPath =
      'https://b8a7a8d6-eb65-4168-add3-b2f1b32fd5f1.mock.pstmn.io/v1';
  static const mediaPath = '$mockPath/mobile/media';
  static const uploadPath = '$mediaPath/upload';

  final Dio _dio;

  const MediaApi(this._dio);

  Future<Blob> postMedia(String filePath) async {
    final data = FormData.fromMap({
      'media': await MultipartFile.fromFile(
        filePath,
        filename: getBasename(filePath),
        contentType: _getMediaType(filePath),
      ),
    });

    final response = await _dio.post(uploadPath, data: data);

    return Blob.fromJson(response.data['data']['media']);
  }

  MediaType? _getMediaType(String filePath) {
    final fileExtension = getFileExtension(filePath);
    final contentType = extensionToContentTypeMap[fileExtension];

    if (contentType != null) {
      return MediaType.parse(contentType);
    }

    return null;
  }

  Future<void> deleteMedia(String id) async {
    final path = '$mediaPath/$id';
    await _dio.delete(path);
  }
}
