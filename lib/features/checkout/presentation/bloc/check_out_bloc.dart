import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/features/account/domain/entitites/address_entity.dart';
import 'package:ecommerce_app/features/checkout/domain/entities/order_entity.dart';
import 'package:ecommerce_app/features/checkout/domain/use_cases/fetch_orders_use_case.dart';
import 'package:ecommerce_app/features/checkout/domain/use_cases/place_order_use_case.dart';
import 'package:ecommerce_app/features/checkout/domain/use_cases/track_order_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_out_event.dart';
part 'check_out_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  final PlaceOrderUseCase placeOrderUseCase;
  final FetchOrdersUseCase fetchOrdersUseCase;
  final TrackOrderUseCase trackOrderUseCase;
  CheckOutBloc({
    required this.placeOrderUseCase,
    required this.fetchOrdersUseCase,
    required this.trackOrderUseCase,
  }) : super(CheckOutInitial()) {
    on<PlaceOrderEvent>((event, emit) async {
      emit(CheckOutLoading());
      final result = await placeOrderUseCase(
        address: event.address,
        products: event.products,
        paymentMethod: event.paymentMethod,
        total: event.total,
      );
      result.fold(
        (l) => emit(CheckOutError(message: l.message)),
        (r) => emit(CheckOutSuccess(orders: [r])),
      );
    });
    on<FetchOrdersEvent>((event, emit) async {
      emit(CheckOutLoading());
      final result = await fetchOrdersUseCase();
      result.fold(
        (failure) => emit(CheckOutError(message: failure.message)),
        (orders) => emit(CheckOutSuccess(orders: orders)),
      );
    });
    on<TrackOrdersEvent>((event, emit) async {
      emit(CheckOutLoading());

      final either = trackOrderUseCase(event.id);

      await either.fold(
        (failure) async {
          emit(CheckOutError(message: failure.message));
        },
        (orderStream) async {
          final orders = <OrderEntity>[];
          await emit.forEach<OrderEntity>(
            orderStream,
            onData: (order) {
              orders.add(order);
              return CheckOutSuccess(orders: List.from(orders));
            },
            onError: (_, __) => CheckOutError(message: 'Unexpected Error'),
          );
        },
      );
    });
  }
}
