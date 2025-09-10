import 'package:ecommerce_app/features/cart/domain/use_cases/add_to_cart_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/get_all_carts_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/remove_from_cart_use_case.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetAllCartsUseCase getAllCartsUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;

  CartBloc({
    required this.getAllCartsUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
  }) : super(CartInitial()) {
    /// Load all carts
    on<GetAllCartsEvent>((event, emit) async {
      emit(CartLoading());
      final result = await getAllCartsUseCase();
      result.fold(
        (failure) => emit(CartError(message: failure.message)),
        (products) => emit(CartLoaded(products: products)),
      );
    });

    /// Add product to cart
    on<AddToCartEvent>((event, emit) async {
      final result = await addToCartUseCase(event.product);

      result.fold((failure) => emit(CartError(message: failure.message)), (
        product,
      ) {
        if (state is CartLoaded) {
          // final current = state as CartLoaded;
          emit(CartLoaded(products: product));
        } else {
          // First item case
          emit(CartLoaded(products: product));
        }
      });
    });

    /// Remove product from cart
    on<RemoveFromCartEvent>((event, emit) async {
      final result = await removeFromCartUseCase(event.product);

      result.fold((failure) => emit(CartError(message: failure.message)), (
        product,
      ) {
        if (state is CartLoaded) {
          final current = state as CartLoaded;
          emit(
            CartLoaded(
              products: current.products
                  .where((p) => p.id != product.id)
                  .toList(),
            ),
          );
        } else {
          // If somehow cart is empty, just reset
          emit(CartLoaded(products: []));
        }
      });
    });
    on<IncreaseQuantityEvent>((event, emit) {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final updatedProducts = currentState.products.map((product) {
          if (product.id == event.productId) {
            return product.copyWith(
              quantity: product.quantity + 1,
            ); // ✅ increment only this one
          }
          return product;
        }).toList();
        emit(CartLoaded(products: updatedProducts));
      }
    });

    on<DecreaseQuantityEvent>((event, emit) {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final updatedProducts = currentState.products.map((product) {
          if (product.id == event.productId && product.quantity > 1) {
            return product.copyWith(quantity: product.quantity - 1);
          }
          return product;
        }).toList();
        emit(CartLoaded(products: updatedProducts));
      }
    });
  }
}
