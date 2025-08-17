import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/auth/data/data_source/remote_data_sources/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/auth/domain/entities/auth_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, AuthEntity>> resetPassword(String email) async {
    return await remoteDataSource.resetPassword(email);
  }

  @override
  Future<Either<Failure, AuthEntity>> signIn(String email, String password) {
    return remoteDataSource.signIn(email, password);
  }

  @override
  Future<Either<Failure, void>> signOut() {
    return remoteDataSource.signOut();
  }

  @override
  Future<Either<Failure, AuthEntity>> signUp(
    String fullName,
    String email,
    String password,
  ) {
    return remoteDataSource.signUp(fullName, email, password);
  }
}
