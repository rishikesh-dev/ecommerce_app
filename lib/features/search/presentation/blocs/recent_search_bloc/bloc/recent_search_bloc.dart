import 'package:ecommerce_app/features/search/domain/use_cases/add_recent_search_use_case.dart';
import 'package:ecommerce_app/features/search/domain/use_cases/clear_recent_search_use_case.dart';
import 'package:ecommerce_app/features/search/domain/use_cases/load_recent_search_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recent_search_event.dart';
part 'recent_search_state.dart';

class RecentSearchBloc extends Bloc<RecentSearchEvent, RecentSearchState> {
  final LoadRecentSearchUseCase loadRecentSearchUseCase;
  final AddRecentSearchUseCase addRecentSearchUseCase;
  final ClearRecentSearchUseCase clearRecentSearchUseCase;

  RecentSearchBloc(
    this.loadRecentSearchUseCase,
    this.addRecentSearchUseCase,
    this.clearRecentSearchUseCase,
  ) : super(RecentSearchInitial()) {
    on<LoadRecentSearchesEvent>(_onLoadRecentSearches);
    on<AddRecentSearchEvent>(_onAddRecentSearch);
    on<ClearRecentSearchesEvent>(_onClearRecentSearches);
  }

  Future<void> _onLoadRecentSearches(
    LoadRecentSearchesEvent event,
    Emitter<RecentSearchState> emit,
  ) async {
    emit(RecentSearchesLoading());
    try {
      final searches = await loadRecentSearchUseCase();
      emit(RecentSearchesLoaded(searches));
    } catch (e) {
      emit(RecentSearchesError(e.toString()));
    }
  }

  Future<void> _onAddRecentSearch(
    AddRecentSearchEvent event,
    Emitter<RecentSearchState> emit,
  ) async {
    emit(RecentSearchesLoading());
    try {
      await addRecentSearchUseCase(event.query);
      final searches = await loadRecentSearchUseCase();
      emit(RecentSearchesLoaded(searches));
    } catch (e) {
      emit(RecentSearchesError(e.toString()));
    }
  }

  Future<void> _onClearRecentSearches(
    ClearRecentSearchesEvent event,
    Emitter<RecentSearchState> emit,
  ) async {
    emit(RecentSearchesLoading());
    try {
      await clearRecentSearchUseCase();
      emit(RecentSearchesLoaded([]));
    } catch (e) {
      emit(RecentSearchesError(e.toString()));
    }
  }
}
