import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/entities/entities/category_entity.dart';
import 'package:ecommerce_app/features/home/domain/repositories/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchCategoriesUseCase {
  final CategoryRepository repository;

  FetchCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call() {
    return repository.fetchCategories();
  }
}