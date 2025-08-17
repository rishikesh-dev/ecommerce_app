
import 'package:ecommerce_app/features/details/domain/entity/details_entity.dart';
import 'package:ecommerce_app/features/details/domain/use_cases/details_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final DetailsUseCase detailsUseCase;
  DetailsBloc({required this.detailsUseCase}) : super(DetailsInitial()) {
    on<LoadDetailsEvent>((event, emit) async {
      emit(DetailsLoading());
      try {
        final details = await detailsUseCase.call(event.id);
        emit(DetailsLoaded(details: details));
      } catch (e) {
        emit(DetailsError(message: e.toString()));
      }
    });
  }
}
