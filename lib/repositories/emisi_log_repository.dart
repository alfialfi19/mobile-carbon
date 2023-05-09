import '../api/api.dart';
import '../models/models.dart';

class EmisiLogRepository {
  final EmisiLogApi _emisiLogApi;

  EmisiLogRepository(this._emisiLogApi);

  Future<List<EmisiLog>> getEmisiLog({
    int? page,
  }) async {
    final response = await _emisiLogApi.getEmisiLog(
      page: page,
    );

    return response;
  }

  Future<void> storeEmisiLog({
    String? idCategory,
    String? idSubCategory,
    String? val,
    String? unit,
  }) async {
    await _emisiLogApi.storeEmisiLog(
      idCategory: idCategory,
      idSubCategory: idSubCategory,
      val: val,
      unit: unit,
    );
  }

  Future<void> storeEmisiLogMultiple({
    List<EmisiCategory>? listEmisi,
    List<String>? listVal,
  }) async {
    await _emisiLogApi.storeEmisiLogMultiple(
      listEmisi: listEmisi,
      listVal: listVal,
    );
  }
}
