
import 'package:ecommerce_app/features/details/domain/entity/details_entity.dart';
import 'package:ecommerce_app/features/details/domain/repositories/details_repository.dart';

class DetailsUseCase {
  final DetailsRepository detailsRepository;

  DetailsUseCase({required this.detailsRepository});

  Future<DetailsEntity> call(int id) {
    return detailsRepository.getDetails(id);
  }
}