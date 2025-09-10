import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/home/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchProductByCategoryUseCase {
  final ProductRepository repository;

  FetchProductByCategoryUseCase({required this.repository});
  Future<Either<Failure, List<ProductEntity>>> call(String category) async {
    return repository.fetchProductByCategory(category);
  }
}
