import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/features/home/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchProductUseCase {
  final ProductRepository _repository;

  FetchProductUseCase(this._repository);

  Future<Either<Failure, List<ProductModel>>> call() {
    return _repository.getProducts();
  }
}
