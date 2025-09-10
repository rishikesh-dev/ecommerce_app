import 'package:ecommerce_app/features/account/presentation/screens/help_center/domain/entity/customer_service_entity.dart';

class CustomerServiceModel extends CustomerServiceEntity {
  CustomerServiceModel({
    required super.messageId,
    required super.user,
    required super.message,
    required super.time,
  });
  factory CustomerServiceModel.fromjson(Map<String, dynamic> json) {
    return CustomerServiceModel(
      messageId: json['messageId'],
      user: json['user'],
      message: json['message'],
      time: json['time'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'user': user,
      'message': message,
      'time': time,
    };
  }
}
