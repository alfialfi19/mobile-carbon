import 'package:dio/dio.dart';
import 'package:mobile_carbon/models/models.dart';

class NotificationApi {
  static const notificationPath = '/notification';
  static const notificationListPath = '/notification/list';
  static const notificationDetailPath = '/notification/detail';

  final Dio _dio;

  NotificationApi(this._dio);

  Future<List<NotificationDetail>> getListNotification({
    String? status,
  }) async {
    List<NotificationDetail> results = [];

    final queries = {
      'status': status ?? "Aktif",
    };

    final response = await _dio.get(
      notificationListPath,
      queryParameters: queries,
    );

    if (response.data != null && response.data['data'] != null) {
      List rawData = response.data['data'];

      for (Map data in rawData) {
        results.add(
          NotificationDetail.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      }
    }

    return results;
  }

  Future<NotificationDetail> getDetailNotification({
    String? id,
  }) async {
    final queries = {
      'id': id ?? "0",
    };

    final response = await _dio.get(
      notificationDetailPath,
      queryParameters: queries,
    );

    return NotificationDetail.fromJson(response.data['data']);
  }
}
