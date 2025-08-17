import 'package:ecommerce_app/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel({required super.id, required super.email, required super.fullName});
  AuthModel.fromJson(AuthEntity authEntity)
    : super(
        id: authEntity.id,
        email: authEntity.email,
        fullName: authEntity.fullName,
      );
  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'fullName': fullName};
  }
}
