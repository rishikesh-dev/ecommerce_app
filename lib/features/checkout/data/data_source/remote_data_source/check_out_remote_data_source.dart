import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/push_notification/data/remote_data_source/remote_push_notification_data_source.dart';
import 'package:ecommerce_app/core/push_notification/data/repositories/push_notification_repository_impl.dart';
import 'package:ecommerce_app/core/push_notification/domain/use_cases/send_notification_use_case.dart';
import 'package:ecommerce_app/core/secrets/app_secrets.dart';
import 'package:ecommerce_app/features/account/domain/entitites/address_entity.dart';
import 'package:ecommerce_app/features/checkout/data/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class CheckOutRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CheckOutRemoteDataSource({required this.firestore, required this.auth});

  Future<Either<Failure, OrderModel>> placeOrder(
    List<ProductEntity> products,
    String status,
    bool isDelivered,
    String paymentMethod,
    String deliveryAddress,
    DateTime orderDate,
    AddressEntity address,
  ) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return left(Failure(message: 'User is not logged in'));
      }

      final orderId = firestore
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .doc()
          .id;

      final totalAmount = products.fold<double>(
        0,
        (total, p) => total + (p.price * p.quantity),
      );
      final orderModel = OrderModel(
        id: orderId,
        address: address,
        totalAmount: totalAmount,
        status: 'Pending',
        paymentMethod: paymentMethod,
        deliveryAddress: deliveryAddress,
        orderDate: orderDate,
        isDelivered: false,
        products: products,
      );

      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .doc(orderId)
          .set(orderModel.toMap());
      simulateOrderProgress(orderId, user.uid);

      return right(orderModel);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<void> simulateOrderProgress(String orderId, String userId) async {
    final steps = ['Processing', 'Shipped', 'Delivered'];

    final userDoc = await firestore.collection('users').doc(userId).get();
    final token = userDoc.data()?['fcmToken'];

    for (final status in steps) {
      await Future.delayed(const Duration(seconds: 10));

      await firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .update({'status': status});

      if (status == 'Delivered') {
        await firestore
            .collection('users')
            .doc(userId)
            .collection('orders')
            .doc(orderId)
            .update({'isDelivered': true});
      }

      if (token != null) {
        SendOrderUpdateNotificationUseCase(
          PushNotificationRepositoryImpl(
            remoteDataSource: PushNotificationDataSourceImpl(
              serverKey: AppSecrets.senderKey,
            ),
          ),
        );
      }
    }
  }

  Future<Either<Failure, List<OrderModel>>> fetchOrders() async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return left(Failure(message: 'User is not logged in'));
      }
      final snapshots = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .get();
      final orders = snapshots.docs
          .map((order) => OrderModel.fromMap(order.data()))
          .toList();
      return right(orders);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Either<Failure, Stream<OrderModel>> trackOrder(String orderId) {
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        return left(Failure(message: 'User is not logged in'));
      }

      final stream = firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .snapshots()
          .map((snapshot) {
            if (snapshot.exists) {
              return OrderModel.fromMap(snapshot.data()!);
            } else {
              // instead of throwing, return a dummy error model or handle separately
              throw Exception('Order not found');
            }
          });

      return right(stream);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
