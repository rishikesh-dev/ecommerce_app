import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/home/data/data_sources/remote_data_sources/product_remote_data_source.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/features/home/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() {
    return remoteDataSource.getProducts();
  }

  @override
  Future<Either<Failure, ProductModel>> getProductById(String id) {
    return remoteDataSource.getProductById(id);
  }

  
}
