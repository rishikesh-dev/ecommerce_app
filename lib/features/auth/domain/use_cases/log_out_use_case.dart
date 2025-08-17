import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogOutUseCase {
  final AuthRepository authRepository;

  LogOutUseCase({required this.authRepository});

  Future<Either<Failure, void>> call() async {
    return await authRepository.signOut();
  }
}
