import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase({required this.repository});
  Future<Either<Failure, List<ProductEntity>>> call(ProductEntity product) {
    return repository.addToCart(product);
  }
}