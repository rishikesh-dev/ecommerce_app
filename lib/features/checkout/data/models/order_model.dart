import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/features/account/data/models/address_model.dart';

import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.address,
    required super.products,
    required super.totalAmount,
    required super.paymentMethod,
    required super.deliveryAddress,
    required super.status,
    required super.orderDate,
    super.isDelivered = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': (address as AddressModel).toJson(),
      'products': products
          .map(
            (p) => {
              'productId': p.id,
              'title': p.title,
              'price': p.price,
              'quantity': p.quantity,
              'thumbnail': p.thumbnail,
              'category': p.category,
            },
          )
          .toList(),
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'deliveryAddress': deliveryAddress,
      'status': status,
      'orderDate': orderDate.toIso8601String(),
      'isDelivered': isDelivered,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      address: AddressModel.fromJson(map['address']),
      products: (map['products'] as List)
          .map(
            (p) => ProductEntity(
              id: p['productId'],
              title: p['title'],
              price: (p['price'] as num).toDouble(),
              quantity: p['quantity'],
              description: p['description'] ?? '',
              thumbnail: p['thumbnail'] ?? '',
              category: p['category'] ?? '',
            ),
          )
          .toList(),
      totalAmount: (map['totalAmount'] as num).toDouble(),
      paymentMethod: map['paymentMethod'],
      deliveryAddress: map['deliveryAddress'],
      status: map['status'],
      orderDate: DateTime.parse(map['orderDate']),
      isDelivered: map['isDelivered'] ?? false,
    );
  }
}
