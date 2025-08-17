import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/features/search/domain/use_cases/search_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase searchUseCase;
  SearchBloc(this.searchUseCase) : super(SearchInitial()) {
    on<SearchQueryChangedEvent>((event, emit) async {
      emit(SearchLoading());
      final result = await searchUseCase.call(event.query);
      result.fold(
        (error) => emit(SearchError(error.message)),
        (data) => emit(SearchLoaded(data)),
      );
    });
    on<SearchResultsClearEvent>((event, emit) {
      // Clear the search results
      emit(SearchInitial());
    });
  }
}
