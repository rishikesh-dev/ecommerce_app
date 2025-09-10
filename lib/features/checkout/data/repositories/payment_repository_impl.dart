import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/checkout/data/data_source/remote_data_source/payment_remote_data_source.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/payment_repository.dart';
import 'package:fpdart/fpdart.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, Unit>> processPayment({
    required String orderId,
    required String description,
    required String currency,
    required double amount,
    required String method,
  }) async {
    return remoteDataSource.processPayment(
      orderId: orderId,
      description: description,
      currency: currency,
      amount: amount,
      method: method,
    );
  }
}
