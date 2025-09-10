import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/account/domain/entitites/user_entity.dart';

abstract class CustomerServiceEntity {
  final String messageId;
  final UserEntity user;
  final String message;
  final Timestamp time;

  CustomerServiceEntity({
    required this.messageId,
    required this.user,
    required this.message,
    required this.time,
  });
}
