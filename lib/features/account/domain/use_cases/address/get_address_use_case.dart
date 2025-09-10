import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/domain/entitites/address_entity.dart';
import 'package:ecommerce_app/features/account/domain/repositories/address_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAddressUseCase {
  final AddressRepository addressRepository;

  GetAddressUseCase({required this.addressRepository});
  Future<Either<Failure, List<AddressEntity>>> call() async {
    return await addressRepository.getAddresses();
  }
}
