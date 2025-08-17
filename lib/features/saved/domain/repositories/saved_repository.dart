import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class SavedRepository {
  Future<Either<Failure, List<ProductEntity>>> getSavedItems();
  Future<Either<Failure, ProductEntity>> saveItem(ProductEntity item);
  Future<Either<Failure, ProductEntity>> removeItem(ProductEntity item);
}
