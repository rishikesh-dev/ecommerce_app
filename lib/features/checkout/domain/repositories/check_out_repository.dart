import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/domain/entitites/address_entity.dart';
import 'package:ecommerce_app/features/checkout/domain/entities/order_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CheckOutRepository {
  Future<Either<Failure, OrderEntity>> placeOrder(
    OrderEntity order,
    AddressEntity address,
  );
  Future<Either<Failure, Unit>> cancelOrder(String orderId);
  Future<Either<Failure, List<OrderEntity>>> fetchOrders();
  Either<Failure, Stream<OrderEntity>> trackOrder(String orderId);
}
