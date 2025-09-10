part of 'check_out_bloc.dart';

@immutable
sealed class CheckOutState {}

final class CheckOutInitial extends CheckOutState {}

final class CheckOutLoading extends CheckOutState {}

final class CheckOutSuccess extends CheckOutState {
  final List<OrderEntity> orders;

  CheckOutSuccess({required this.orders});
}

final class CheckOutError extends CheckOutState {
  final String message;

  CheckOutError({required this.message});
}
