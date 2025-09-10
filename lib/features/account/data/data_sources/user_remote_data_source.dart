import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/data/models/user_model.dart';
import 'package:ecommerce_app/features/account/domain/entitites/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class UserRemoteDataSource {
  final FirebaseAuth auth;

  UserRemoteDataSource({required this.auth});
  Future<Either<Failure, UserEntity>> getUserDetails() async {
    try {
      final user = auth.currentUser;
      return right(UserModel.fromDB(user));
    } on FirebaseAuthException catch (e) {
      return left(Failure(message: e.code));
    }
  }

  Future<Either<Failure, UserEntity>> updateUserDetails(
    String? fullName,
  ) async {
    try {
      final user = auth.currentUser;
      if (fullName != null && fullName.isNotEmpty) {
        await user?.updateDisplayName(fullName);
      }
      await user?.reload();
      final updatedUser = auth.currentUser!;
      return right(UserModel.fromDB(updatedUser));
    } on FirebaseAuthException catch (e) {
      return left(Failure(message: e.code));
    }
  }
}
