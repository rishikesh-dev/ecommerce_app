import 'package:ecommerce_app/features/account/domain/entitites/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.id,
    required super.country,
    required super.isDefault,
    required super.buildingNo,
    required super.fullName,
    required super.landMark,
    required super.area,
    required super.town,
    required super.state,
    required super.mobileNo,
    required super.pincode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json['id'],
    country: json['country'],
    isDefault: json['isDefault'],
    buildingNo: json['buildingNo'],
    fullName: json['fullName'],
    landMark: json['landMark'],
    area: json['area'],
    town: json['town'],
    state: json['state'],
    mobileNo: json['mobileNo'],
    pincode: json['pincode'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'country': country,
    'buildingNo': buildingNo,
    'fullName': fullName,
    'landMark': landMark,
    'area': area,
    'town': town,
    'state': state,
    'mobileNo': mobileNo,
    'pincode': pincode,
    'isDefault': isDefault,
  };
  @override
  AddressEntity copyWith({
    bool? isDefault,
    String? country,
    String? buildingNo,
    String? fullName,
    String? landMark,
    String? area,
    String? town,
    String? state,
    String? mobileNo,
    String? pincode,
  }) {
    return AddressModel(
      id: id,
      isDefault: isDefault ?? this.isDefault,
      country: country ?? this.country,
      buildingNo: buildingNo ?? this.buildingNo,
      fullName: fullName ?? this.fullName,
      landMark: landMark ?? this.landMark,
      area: area ?? this.area,
      town: town ?? this.town,
      state: state ?? this.state,
      mobileNo: mobileNo ?? this.mobileNo,
      pincode: pincode ?? this.pincode,
    );
  }
}
