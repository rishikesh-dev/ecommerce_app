import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProducts();
  Future<Either<Failure, ProductModel>> getProductById(String id);
}
