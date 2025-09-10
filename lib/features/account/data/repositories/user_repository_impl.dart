import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/data/data_sources/user_remote_data_source.dart';
import 'package:ecommerce_app/features/account/domain/entitites/user_entity.dart';
import 'package:ecommerce_app/features/account/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, UserEntity>> getUserDetails() async {
    return await remoteDataSource.getUserDetails();
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserDetails(
    String? fullName,
  ) async {
    return await remoteDataSource.updateUserDetails(fullName);
  }
}
