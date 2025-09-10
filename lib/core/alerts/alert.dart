import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

ToastificationItem alert(
  String title,
  String message,
  ToastificationType type,
) {
  return toastification.show(
    autoCloseDuration: Duration(seconds: 5),
    title: Text(title),
    description: Text(message),
    type: type,
  );
}
