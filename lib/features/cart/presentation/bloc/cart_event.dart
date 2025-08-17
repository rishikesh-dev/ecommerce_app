part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class GetAllCartsEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final ProductEntity product;

  AddToCartEvent({required this.product});
}

class RemoveFromCartEvent extends CartEvent {
  final ProductEntity product;

  RemoveFromCartEvent({required this.product});
}
