import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/domain/entitites/address_entity.dart';
import 'package:ecommerce_app/features/checkout/domain/entities/order_entity.dart';
import 'package:ecommerce_app/features/checkout/domain/repositories/check_out_repository.dart';
import 'package:fpdart/fpdart.dart';

class PlaceOrderUseCase {
  final CheckOutRepository repository;
  PlaceOrderUseCase(this.repository);

  Future<Either<Failure, OrderEntity>> call({
    required List<ProductEntity> products,
    required String paymentMethod,
    required AddressEntity address,
    required double total,
  }) async {
    if (address.id.isEmpty) {
      return left(Failure(message: 'No address selected'));
    }
    final order = OrderEntity(
      id: products.map((p) => p.id).join(","),
      address: address,
      products: products,
      totalAmount: total,
      paymentMethod: paymentMethod,
      deliveryAddress:
          '${address.buildingNo} ${address.area}  ${address.town} ${address.pincode} ${address.state} ${address.country}',
      status: 'Pending',
      orderDate: DateTime.now(),
    );
    return await repository.placeOrder(order, address);
  }
}
