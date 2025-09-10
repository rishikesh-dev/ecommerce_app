import 'package:ecommerce_app/features/account/domain/entitites/user_entity.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/user/get_user_details_use_case.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/user/update_user_details_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserDetailsUseCase getUserDetailsUseCase;
  final UpdateUserDetailsUseCase updateUserDetailsUseCase;
  UserBloc({
    required this.getUserDetailsUseCase,
    required this.updateUserDetailsUseCase,
  }) : super(UserInitial()) {
    on<GetUserEvent>((event, emit) async {
      emit(UserLoading());
      final result = await getUserDetailsUseCase();
      result.fold(
        (failure) => emit(UserError(message: failure.message)),
        (user) => emit(UserLoaded(userEntity: user)),
      );
    });
    on<UpdateUserEvent>((event, emit) async {
      emit(UserLoading());
      final result = await updateUserDetailsUseCase(event.fullName);
      result.fold(
        (failure) => emit(UserError(message: failure.message)),
        (updatedUser) => emit(UpdateUserSuccess(userEntity: updatedUser)),
      );
    });
  }
}
