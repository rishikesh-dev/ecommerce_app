import 'package:ecommerce_app/features/details/data/data_sources/remote_data_sources/details_remote_data_source.dart';
import 'package:ecommerce_app/features/details/domain/entity/details_entity.dart';

import 'package:ecommerce_app/features/details/domain/repositories/details_repository.dart';

class DetailsRepositoryImpl extends DetailsRepository {
  final DetailsRemoteDataSource remoteDataSource;

  DetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DetailsEntity> getDetails(int id) async {
    return await remoteDataSource.getDetails(id);
  }
}
