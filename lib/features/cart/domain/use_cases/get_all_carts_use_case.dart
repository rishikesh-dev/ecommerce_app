import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllCartsUseCase {
  final CartRepository repository;

  GetAllCartsUseCase({required this.repository});
  Future<Either<Failure, List<ProductEntity>>> call() {
    return repository.getAllCarts();
  }
}
