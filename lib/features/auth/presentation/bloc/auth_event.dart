part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSignUpRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  AuthSignUpRequested({
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  String toString() => 'AuthSignUpRequested(email: $email, password: ***)';
}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  AuthSignInRequested({required this.email, required this.password});

  @override
  String toString() => 'AuthLoginRequested(email: $email, password: ***)';
}

// Auth Reset Password
class AuthResetPasswordRequested extends AuthEvent {
  final String email;

  AuthResetPasswordRequested({required this.email});
}

class AuthLogoutRequested extends AuthEvent {}
