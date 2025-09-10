import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class PushNotificationDataSource {
  Future<void> sendPushNotification({
    required String token,
    required String title,
    required String body,
  });
}

class PushNotificationDataSourceImpl implements PushNotificationDataSource {
  final String _serverKey;

  PushNotificationDataSourceImpl({required String serverKey})
    : _serverKey = serverKey;

  @override
  Future<void> sendPushNotification({
    required String token,
    required String title,
    required String body,
  }) async {
    final response = await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key=$_serverKey",
      },
      body: jsonEncode({
        "to": token,
        "notification": {"title": title, "body": body},
        "priority": "high",
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("FCM error: ${response.body}");
    }
  }
}
