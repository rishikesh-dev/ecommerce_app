import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, ProductEntity>> getProductById(String id);
  Future<Either<Failure, List<ProductEntity>>> fetchProductByCategory(String category);
}
