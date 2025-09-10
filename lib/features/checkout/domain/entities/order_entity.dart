import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/features/account/domain/entitites/address_entity.dart';

class OrderEntity {
  final String id;
  final AddressEntity address;
  final List<ProductEntity> products;
  final double totalAmount;
  final String paymentMethod;
  final String deliveryAddress;
  final String status;
  final DateTime orderDate;
  final bool isDelivered;

  const OrderEntity({
    required this.id,
    required this.address,
    required this.products,
    required this.totalAmount,
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.status,
    required this.orderDate,
    this.isDelivered = false,
  });
}
