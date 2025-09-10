part of 'check_out_bloc.dart';

@immutable
sealed class CheckOutEvent {}

class PlaceOrderEvent extends CheckOutEvent {
  final List<ProductEntity> products;
  final String paymentMethod;
  final AddressEntity address;
  final double total;

  PlaceOrderEvent({
    required this.products,
    required this.paymentMethod,
    required this.address,
    required this.total,
  });
}

class FetchOrdersEvent extends CheckOutEvent {}

class TrackOrdersEvent extends CheckOutEvent {
  final String id;

  TrackOrdersEvent({required this.id});
}
