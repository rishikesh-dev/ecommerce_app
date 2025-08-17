import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entities/auth_entity.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/log_out_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final LogOutUseCase logOutUseCase;
  AuthBloc(
    this.signInUseCase,
    this.signUpUseCase,
    this.resetPasswordUseCase,
    this.logOutUseCase,
  ) : super(AuthInitial()) {
    on<AuthSignUpRequested>((event, emit) async {
      emit(AuthLoadingState());
      final result = await signUpUseCase(
        event.fullName,
        event.email,
        event.password,
      );
      result.fold(
        (failure) =>
            emit(AuthErrorState(message: Failure(message: failure.message))),
        (user) => emit(Authenticated(user: user)),
      );
    });
    on<AuthSignInRequested>((event, emit) async {
      emit(AuthLoadingState());
      final result = await signInUseCase(event.email, event.password);
      result.fold(
        (failure) => emit(AuthErrorState(message: failure)),
        (user) => emit(Authenticated(user: user)),
      );
    });
    on<AuthLogoutRequested>((event, emit) async {
      emit(AuthLoadingState());
      final result = await logOutUseCase();
      result.fold(
        (failure) => emit(AuthErrorState(message: failure)),
        (_) => emit(AuthSignedOut()),
      );
    });
  }
}
