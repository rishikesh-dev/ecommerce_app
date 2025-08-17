import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/features/saved/data/data_sources/remote_data_sources/saved_remote_data_source.dart';
import 'package:ecommerce_app/features/saved/domain/repositories/saved_repository.dart';
import 'package:fpdart/fpdart.dart';

class SavedRepositoriesImpl extends SavedRepository {
  final SavedRemoteDataSource remoteDataSource;

  SavedRepositoriesImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getSavedItems() async {
    return await remoteDataSource.getSavedItems();
  }

  @override
  Future<Either<Failure, ProductEntity>> removeItem(
    ProductEntity item,
  ) async {
    return await remoteDataSource.removeItem(ProductModel.fromEntity(item));
  }

  @override
  Future<Either<Failure, ProductEntity>> saveItem(ProductEntity item) {
    return remoteDataSource.saveItem(ProductModel.fromEntity(item));
  }
}
