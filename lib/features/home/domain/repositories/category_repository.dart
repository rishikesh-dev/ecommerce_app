import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/entities/entities/category_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> fetchCategories();
}
