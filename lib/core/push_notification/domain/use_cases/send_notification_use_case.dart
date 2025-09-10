import 'package:ecommerce_app/core/push_notification/domain/repositories/push_notification_repository.dart';

class SendOrderUpdateNotificationUseCase {
  final PushNotificationRepository repository;

  SendOrderUpdateNotificationUseCase(this.repository);

  Future<void> call({required String token, required String status}) async {
    await repository.sendNotification(
      token: token,
      title: "Order Update",
      body: "Your order status changed to $status",
    );
  }
}
