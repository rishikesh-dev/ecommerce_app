import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/data/data_sources/address_remote_data_source.dart';
import 'package:ecommerce_app/features/account/domain/entitites/address_entity.dart';
import 'package:ecommerce_app/features/account/domain/repositories/address_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepositoryImpl({required this.remoteDataSource});
  @override
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
  }) async {
    return remoteDataSource.addAddress(
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

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddresses() {
    return remoteDataSource.getAddresses();
  }

  @override
  Future<Either<Failure, Unit>> deleteAddress(String addressId) async {
    return await remoteDataSource.deleteAddress(addressId);
  }

  @override
  Future<Either<Failure, Unit>> setDefaultAddress(String addressId) async {
    return await remoteDataSource.updateDefaultAddress(addressId);
  }

  @override
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
  }) async {
    return remoteDataSource.updateAddress(
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
