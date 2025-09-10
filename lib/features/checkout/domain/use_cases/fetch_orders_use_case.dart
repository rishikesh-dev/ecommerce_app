import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/checkout/domain/entities/order_entity.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/check_out_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchOrdersUseCase {
  final CheckOutRepository repository;

  FetchOrdersUseCase({required this.repository});

  Future<Either<Failure, List<OrderEntity>>> call() async {
    return await repository.fetchOrders();
  }
}
