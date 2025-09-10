part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentProcessing extends PaymentState {}

final class PaymentSuccess extends PaymentState {}

final class PaymentFailed extends PaymentState {
  final String message;

  PaymentFailed({required this.message});
}
