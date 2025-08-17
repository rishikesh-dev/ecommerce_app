part of 'recent_search_bloc.dart';

@immutable
sealed class RecentSearchEvent {}

class LoadRecentSearchesEvent extends RecentSearchEvent {}

class AddRecentSearchEvent extends RecentSearchEvent {
  final String query;

  AddRecentSearchEvent(this.query);
}

class ClearRecentSearchesEvent extends RecentSearchEvent {}
