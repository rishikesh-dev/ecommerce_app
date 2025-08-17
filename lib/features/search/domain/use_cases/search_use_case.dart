import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/features/search/domain/repositories/search_repository.dart';
import 'package:fpdart/fpdart.dart';

class SearchUseCase {
  final SearchRepository repository;

  SearchUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call(String query) {
    return repository.search(query);
  }
}
