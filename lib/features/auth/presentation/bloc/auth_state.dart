part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final Failure message;
  AuthErrorState({required this.message});
}

class Authenticated extends AuthState {
  final AuthEntity user;

  Authenticated({required this.user});
}

class AuthSignedOut extends AuthState {}
