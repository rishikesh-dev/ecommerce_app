import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/domain/entitites/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUserDetails();
  Future<Either<Failure, UserEntity>> updateUserDetails(String? fullName);
}
