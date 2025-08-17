import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entities/auth_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCase({required this.authRepository});

  Future<Either<Failure, AuthEntity>> call(String email, String password) async {
    return await authRepository.resetPassword(email);
  }
}
