import 'package:ecommerce_app/core/entities/entities/category_entity.dart';
import 'package:ecommerce_app/features/home/domain/use_cases/fetch_categories_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final FetchCategoriesUseCase categoriesUseCase;
  CategoryBloc(this.categoriesUseCase) : super(CategoryInitial()) {
    on<FetchCategoryEvent>((event, emit) async {
      emit(CategoryLoading());
      // Simulate a network call
      final result = await categoriesUseCase();
      result.fold(
        (error) => emit(CategoryError(error.message)),
        (categories) => emit(CategoryLoaded(categories)),
      );
    });
  }
}
