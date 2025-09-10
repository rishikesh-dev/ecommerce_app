import 'package:ecommerce_app/features/account/domain/entitites/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel({required super.email, required super.fullName});
  factory UserModel.fromDB(User? user) {
    return UserModel(
      email: user?.email ?? '',
      fullName: user?.displayName ?? '',
    );
  }
  Map<String, dynamic> toJson() => {'email': email, 'fullName': fullName};
}
