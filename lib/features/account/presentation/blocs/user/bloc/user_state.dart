part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserEntity userEntity;

  UserLoaded({required this.userEntity});
}

class UserError extends UserState {
  final String message;

  UserError({required this.message});
}

//Update user
class UpdateUserSuccess extends UserState {
  final UserEntity userEntity;

  UpdateUserSuccess({required this.userEntity});
}
