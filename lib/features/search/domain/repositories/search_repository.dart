import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<ProductEntity>>> search(String query);
}
