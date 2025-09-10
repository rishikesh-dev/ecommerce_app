class PaymentEntity {
  final String id;
  final String cardNumber;
  final String validity;
  final String securityCode;
  final String holderName;
  final bool isDefault;

  PaymentEntity({
    required this.id,
    required this.cardNumber,
    required this.validity,
    required this.securityCode,
    required this.holderName,
    required this.isDefault
  });
}
