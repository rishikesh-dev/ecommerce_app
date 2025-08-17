import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/features/search/data/data_source/remote_data_sources/search_remote_data_source.dart';

import 'package:ecommerce_app/features/search/domain/repositories/search_repository.dart';
import 'package:fpdart/fpdart.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  SearchRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> search(String query) async {
    return await remoteDataSource.search(query);
  }


}
