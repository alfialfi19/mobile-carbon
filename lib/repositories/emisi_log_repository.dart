import '../api/api.dart';
import '../models/models.dart';

class EmisiLogRepository {
  final EmisiLogApi _emisiLogApi;

  EmisiLogRepository(this._emisiLogApi);

  Future<List<EmisiLog>> getEmisiLog({
    int? page,
  }) async {
    final response = _emisiLogApi.getEmisiLog(
      page: page,
    );

    return response;
  }
}
