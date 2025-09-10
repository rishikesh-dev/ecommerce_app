abstract class PushNotificationRepository {
  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
  });
}
