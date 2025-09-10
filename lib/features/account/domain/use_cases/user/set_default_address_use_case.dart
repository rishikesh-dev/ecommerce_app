import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/domain/repositories/address_repository.dart';
import 'package:fpdart/fpdart.dart';

class SetDefaultAddressUseCase {
  final AddressRepository addressRepository;
  SetDefaultAddressUseCase(this.addressRepository);
  Future<Either<Failure, Unit>> call(String addressId) async {
    return await addressRepository.setDefaultAddress(addressId);
  }
}
