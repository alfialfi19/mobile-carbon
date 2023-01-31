import '../api/api.dart';
import '../models/blob.dart';

class MediaRepository {
  final MediaApi _api;

  MediaRepository(this._api);

  Future<Blob> create(String filePath) {
    return _api.postMedia(filePath);
  }

  Future<void> deleteById(String id) async {
    _api.deleteMedia(id).catchError((error) {
      // do nothing because unused image will remove by backend
    });
  }
}
