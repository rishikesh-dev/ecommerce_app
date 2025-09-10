import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/domain/entitites/user_entity.dart';
import 'package:ecommerce_app/features/account/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetUserDetailsUseCase {
  final UserRepository userRepository;

  GetUserDetailsUseCase({required this.userRepository});
  Future<Either<Failure, UserEntity>> call() async {
    return await userRepository.getUserDetails();
  }
}
