import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class PaymentRepository {
  Future<Either<Failure, Unit>> processPayment({
    required String orderId,
    required String description,
    required String currency,
    required double amount,
    required String method,
  });
}
