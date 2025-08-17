import 'package:ecommerce_app/features/details/domain/entity/details_entity.dart';

abstract class DetailsRepository {
  Future<DetailsEntity> getDetails(int id);
}
