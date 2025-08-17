import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entities/auth_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, AuthEntity>> signUp(
    String email,
    String password,
    String fullName,
  );
  Future<Either<Failure, AuthEntity>> signIn(String email, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, AuthEntity>> resetPassword(String email);
}
