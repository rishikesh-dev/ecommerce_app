
import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:ecommerce_app/features/cart/data/data_sources/remote_data_sources/cart_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductModel>>> addToCart(
    ProductEntity product,
  ) async {
    final model = ProductModel.fromEntity(product);

    return await remoteDataSource.addToCart(model);
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllCarts() async {
    return await remoteDataSource.getCartItems();
  }

  @override
  Future<Either<Failure, ProductModel>> removeFromCart(
    ProductEntity product,
  ) async {
    return await remoteDataSource.removeFromCart(ProductModel.fromEntity(product));
  }
}
