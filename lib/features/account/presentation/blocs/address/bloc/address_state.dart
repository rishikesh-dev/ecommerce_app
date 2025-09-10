part of 'address_bloc.dart';

@immutable
sealed class AddressState {}

final class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressError extends AddressState {
  final String message;

  AddressError({required this.message});
}

class AddressLoaded extends AddressState {
  final List<AddressEntity> addresses;
  AddressLoaded({required this.addresses});
}
