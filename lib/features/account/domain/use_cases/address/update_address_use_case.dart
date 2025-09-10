import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/domain/entitites/address_entity.dart';
import 'package:ecommerce_app/features/account/domain/repositories/address_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateAddressUseCase {
  final AddressRepository addressRepository;

  UpdateAddressUseCase({required this.addressRepository});
  Future<Either<Failure, AddressEntity>> call({
    required String id,
    required bool isDefault,
    required String country,
    required String buildingNo,
    required String fullName,
    required String landMark,
    required String area,
    required String town,
    required String state,
    required String mobileNo,
    required String pincode,
  }) async {
    return await addressRepository.updateAddress(
      id: id,
      isDefault: isDefault,
      country: country,
      buildingNo: buildingNo,
      fullName: fullName,
      landMark: landMark,
      area: area,
      town: town,
      state: state,
      mobileNo: mobileNo,
      pincode: pincode,
    );
  }
}
