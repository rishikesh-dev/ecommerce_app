abstract class AddressEntity {
  final String id;
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

  AddressEntity({
    required this.id,
    required this.isDefault,
    required this.country,
    required this.buildingNo,
    required this.area,
    required this.fullName,
    required this.landMark,
    required this.town,
    required this.state,
    required this.mobileNo,
    required this.pincode,
  });

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
  });
}
