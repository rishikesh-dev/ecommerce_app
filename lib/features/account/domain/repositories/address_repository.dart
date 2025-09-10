import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/domain/entitites/address_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AddressRepository {
  Future<Either<Failure, List<AddressEntity>>> getAddresses();
  Future<Either<Failure, AddressEntity>> addAddress({
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
  });
  Future<Either<Failure, AddressEntity>> updateAddress({
    required bool isDefault,
    required String id,
    required String country,
    required String buildingNo,
    required String fullName,
    required String landMark,
    required String area,
    required String town,
    required String state,
    required String mobileNo,
    required String pincode,
  });
  Future<Either<Failure, Unit>> deleteAddress(String addressId);
  Future<Either<Failure, Unit>> setDefaultAddress(String addressId);
}
