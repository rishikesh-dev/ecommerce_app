part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

class MakePaymentEvent extends PaymentEvent {
  final String orderId;
  final String description;
  final String username;
  final String currency;
  final double amount;
  final String method;

  MakePaymentEvent({
    required this.orderId,
    required this.description,
    required this.username,
    required this.currency,
    required this.amount,
    required this.method,
  });
}
