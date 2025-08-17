import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/home/data/data_sources/remote_data_sources/category_remote_data_source.dart';
import 'package:ecommerce_app/core/entities/entities/category_entity.dart';
import 'package:ecommerce_app/features/home/domain/repositories/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> fetchCategories() {
    return remoteDataSource.getCategories();
  }
}
