import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/home/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchProductUseCase {
  final ProductRepository _repository;

  FetchProductUseCase(this._repository);

  Future<Either<Failure, List<ProductEntity>>> call() {
    return _repository.getProducts();
  }
}
