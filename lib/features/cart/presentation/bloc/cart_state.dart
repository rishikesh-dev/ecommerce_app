part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ProductEntity> products;

  CartLoaded({required this.products});
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}
