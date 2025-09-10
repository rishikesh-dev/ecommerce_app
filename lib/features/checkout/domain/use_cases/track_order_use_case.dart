import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/checkout/domain/entities/order_entity.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/check_out_repository.dart';
import 'package:fpdart/fpdart.dart';

class TrackOrderUseCase {
  final CheckOutRepository repository;

  TrackOrderUseCase(this.repository);

  Either<Failure, Stream<OrderEntity>> call(String orderId) {
    return repository.trackOrder(orderId);
  }
}
