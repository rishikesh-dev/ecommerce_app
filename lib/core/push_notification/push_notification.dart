import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> saveUserToken(String userId) async {
  final token = await FirebaseMessaging.instance.getToken();
  if (token != null) {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'fcmTokens': FieldValue.arrayUnion([token]),
    }, SetOptions(merge: true));
  }

  // Handle refresh
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    FirebaseFirestore.instance.collection('users').doc(userId).set({
      'fcmTokens': FieldValue.arrayUnion([newToken]),
    }, SetOptions(merge: true));
  });
}
