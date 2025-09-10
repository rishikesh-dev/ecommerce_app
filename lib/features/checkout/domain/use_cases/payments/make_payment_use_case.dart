import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/payment_repository.dart';
import 'package:fpdart/fpdart.dart';

class MakePaymentParams {
  final String orderId;
  final String description;
  final String username;
  final String currency;
  final double amount;
  final String method;
  MakePaymentParams({
    required this.orderId,
    required this.description,
    required this.username,
    required this.currency,
    required this.amount,
    required this.method,
  });
}

class MakePaymentUseCase {
  final PaymentRepository repository;

  MakePaymentUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(MakePaymentParams params) async {
    return repository.processPayment(
      orderId: params.orderId,
      description: params.description,
      currency: params.currency,
      amount: params.amount,
      method: params.method,
    );
  }
}
