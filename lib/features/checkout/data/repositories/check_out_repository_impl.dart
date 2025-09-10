import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/domain/entitites/address_entity.dart';
import 'package:ecommerce_app/features/checkout/data/data_source/remote_data_source/check_out_remote_data_source.dart';
import 'package:ecommerce_app/features/checkout/domain/entities/order_entity.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/check_out_repository.dart';
import 'package:fpdart/fpdart.dart';

class CheckOutRepositoryImpl implements CheckOutRepository {
  final CheckOutRemoteDataSource remoteDataSource;
  CheckOutRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, Unit>> cancelOrder(String orderid) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> fetchOrders() async {
    return await remoteDataSource.fetchOrders();
  }

  @override
  Future<Either<Failure, OrderEntity>> placeOrder(
    OrderEntity orderModel,
    AddressEntity address,
  ) async {
    return await remoteDataSource.placeOrder(
      orderModel.products,
      orderModel.status,
      orderModel.isDelivered,
      orderModel.paymentMethod,
      orderModel.deliveryAddress,
      orderModel.orderDate,
      address
    );
  }

  @override
  Either<Failure, Stream<OrderEntity>> trackOrder(String orderId) {
    return remoteDataSource.trackOrder(orderId);
  }
}
