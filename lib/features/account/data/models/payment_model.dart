import 'package:ecommerce_app/features/account/domain/entitites/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  PaymentModel({
    required super.cardNumber,
    required super.validity,
    required super.securityCode,
    required super.holderName,
    required super.id,
    required super.isDefault,
  });
  PaymentModel copyWith({
    String? id,
    String? cardNumber,
    String? validity,
    String? securityCode,
    String? holderName,
    bool? isDefault,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      validity: validity ?? this.validity,
      securityCode: securityCode ?? this.validity,
      holderName: holderName ?? this.holderName,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  factory PaymentModel.fromEntity(PaymentEntity entity) {
    return PaymentModel(
      cardNumber: entity.cardNumber,
      validity: entity.validity,
      securityCode: entity.securityCode,
      holderName: entity.holderName,
      id: entity.id,
      isDefault: entity.isDefault,
    );
  }
  PaymentEntity toEntity() => PaymentEntity(
    id: id,
    cardNumber: cardNumber,
    validity: validity,
    securityCode: securityCode,
    holderName: holderName,
    isDefault: isDefault,
  );

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      cardNumber: json['cardNumber'],
      validity: json['validity'],
      securityCode: json['securityCode'],
      holderName: json['holderName'],
      isDefault: json['isDefault'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'validity': validity,
      'securityCode': securityCode,
      'holderName': holderName,
      'isDefault': isDefault,
    };
  }
}
