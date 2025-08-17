import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CartRepository {
  Future<Either<Failure, List<ProductEntity>>> addToCart(ProductEntity product);
  Future<Either<Failure, ProductEntity>> removeFromCart(ProductEntity product);
  Future<Either<Failure, List<ProductEntity>>> getAllCarts();
}
