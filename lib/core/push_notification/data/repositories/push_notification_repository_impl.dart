import 'package:ecommerce_app/core/push_notification/data/remote_data_source/remote_push_notification_data_source.dart';
import 'package:ecommerce_app/core/push_notification/domain/repositories/push_notification_repository.dart';

class PushNotificationRepositoryImpl extends PushNotificationRepository {
  final PushNotificationDataSource remoteDataSource;

  PushNotificationRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
  }) async {
    return await remoteDataSource.sendPushNotification(
      token: token,
      title: title,
      body: body,
    );
  }
}
