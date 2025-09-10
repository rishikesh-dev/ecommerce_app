part of 'address_bloc.dart';

@immutable
sealed class AddressEvent {}

class AddAddressEvent extends AddressEvent {
  final bool isDefault;
  final String country;
  final String buildingNo;
  final String fullName;
  final String landMark;
  final String area;
  final String town;
  final String state;
  final String mobileNo;
  final String pincode;

  AddAddressEvent({
    required this.isDefault,
    required this.country,
    required this.buildingNo,
    required this.fullName,
    required this.landMark,
    required this.area,
    required this.town,
    required this.state,
    required this.mobileNo,
    required this.pincode,
  });
}

class UpdateAddressEvent extends AddressEvent {
  final bool isDefault;
  final String id;
  final String country;
  final String buildingNo;
  final String fullName;
  final String landMark;
  final String area;
  final String town;
  final String state;
  final String mobileNo;
  final String pincode;

  UpdateAddressEvent({
    required this.isDefault,
    required this.id,
    required this.country,
    required this.buildingNo,
    required this.fullName,
    required this.landMark,
    required this.area,
    required this.town,
    required this.state,
    required this.mobileNo,
    required this.pincode,
  });
}

class LoadAddressEvent extends AddressEvent {}

class SetDefaultAddressEvent extends AddressEvent {
  final String id;
  SetDefaultAddressEvent({required this.id});
}

class DeleteAddressEvent extends AddressEvent {
  final String id;
  DeleteAddressEvent({required this.id});
}
