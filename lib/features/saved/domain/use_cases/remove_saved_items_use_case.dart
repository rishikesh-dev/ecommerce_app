import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/saved/domain/repositories/saved_repository.dart';
import 'package:fpdart/fpdart.dart';

class RemoveSavedItemsUseCase {
  final SavedRepository repository;

  RemoveSavedItemsUseCase({required this.repository});
  Future<Either<Failure, ProductEntity>> call(ProductEntity item) {
    return repository.removeItem(item);
  }
}
