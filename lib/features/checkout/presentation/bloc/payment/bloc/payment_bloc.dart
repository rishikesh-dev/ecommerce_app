import 'package:ecommerce_app/features/checkout/domain/use_cases/payments/make_payment_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final MakePaymentUseCase makePaymentUseCase;
  PaymentBloc({required this.makePaymentUseCase}) : super(PaymentInitial()) {
    on<MakePaymentEvent>((event, emit) async {
      final result = await makePaymentUseCase(
        MakePaymentParams(
          orderId: event.orderId,
          description: event.description,
          username: event.username,
          currency: event.currency,
          amount: event.amount,
          method: event.method,
        ),
      );
      result.fold(
        (failure) => emit(PaymentFailed(message: failure.message)),
        (success) => emit(PaymentSuccess()),
      );
    });
  }
}
