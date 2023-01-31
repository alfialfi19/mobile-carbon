import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

// Refers to https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types#image_types
class ContentTypeConstant {
  static const pdf = 'application/pdf';
  static const jpg = 'image/jpg';
  static const jpeg = 'image/jpeg';
  static const gif = 'image/gif';
  static const png = 'image/png';
  static const webp = 'image/webp';
  static const svg = 'image/svg+xml';
  static const bmp = 'image/bmp';
}

const extensionToContentTypeMap = {
  FileExtensions.gif: ContentTypeConstant.gif,
  FileExtensions.jpg: ContentTypeConstant.jpeg,
  FileExtensions.jpeg: ContentTypeConstant.jpeg,
  FileExtensions.png: ContentTypeConstant.png,
  FileExtensions.webp: ContentTypeConstant.webp,
  FileExtensions.bmp: ContentTypeConstant.bmp,
  FileExtensions.svg: ContentTypeConstant.svg,
  FileExtensions.pdf: ContentTypeConstant.pdf,
};

class FileExtensions {
  static const gif = 'gif';
  static const jpg = 'jpg';
  static const jpeg = 'jpeg';
  static const png = 'png';
  static const bmp = 'bmp';
  static const webp = 'webp';
  static const pdf = 'pdf';
  static const svg = 'svg';
  static const heic = 'heic';
}

const imageFileExtensions = [
  FileExtensions.gif,
  FileExtensions.jpg,
  FileExtensions.jpeg,
  FileExtensions.png,
  FileExtensions.webp,
  FileExtensions.bmp,
  FileExtensions.svg,
];

String getFileExtension(String path) {
  final name = getBasename(path);
  return name.split('.').last.toLowerCase();
}

String getBasename(String path) {
  return path.split(Platform.pathSeparator).last;
}

String getExtensionFromContentType(String contentType) {
  switch (contentType) {
    case ContentTypeConstant.pdf:
      return '.${FileExtensions.pdf}';
    case ContentTypeConstant.jpeg:
      return '.${FileExtensions.jpg}';
    case ContentTypeConstant.gif:
      return '.${FileExtensions.gif}';
    case ContentTypeConstant.png:
      return '.${FileExtensions.png}';
    case ContentTypeConstant.webp:
      return '.${FileExtensions.webp}';
    case ContentTypeConstant.svg:
      return '.${FileExtensions.svg}';
    default:
      return ''; //Unknown extension
  }
}

String getExtensionFromUrl(String url) {
  return url.split(".").last;
}

Future<File> getFileFromUrl(String imageUrl) async {
  // generate random number.
  final random = Random();

  // get temporary directory of device.
  final tempDir = await getTemporaryDirectory();

  // get temporary path from temporary directory.
  final tempPath = tempDir.path;

  // create a new file in temporary path with random file name.
  final file =
      File('$tempPath${random.nextInt(100)}.${getExtensionFromUrl(imageUrl)}');

  // call http.get method and pass imageUrl into it to get response.
  final response = await http.get(Uri.parse(imageUrl));

  // write bodyBytes received in response to file.
  await file.writeAsBytes(response.bodyBytes);

  // now return the file which is created with random name in
  // temporary directory and image bytes from response is written to // that file.
  return file;
}
