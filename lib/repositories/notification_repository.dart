import 'package:mobile_carbon/api/api.dart';
import 'package:mobile_carbon/models/models.dart';

class NotificationRepository {
  final NotificationApi _notificationApi;

  NotificationRepository(this._notificationApi);

  Future<List<NotificationDetail>> getListNotification({
    String? status,
  }) async {
    final response = await _notificationApi.getListNotification(
      status: status,
    );

    return response;
  }
}
