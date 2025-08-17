part of 'recent_search_bloc.dart';

@immutable
sealed class RecentSearchState {}

final class RecentSearchInitial extends RecentSearchState {}

class RecentSearchesLoading extends RecentSearchState {}

class RecentSearchesError extends RecentSearchState {
  final String message;

  RecentSearchesError(this.message);
}

class RecentSearchesLoaded extends RecentSearchState {
  final List<String> recentSearches;

  RecentSearchesLoaded(this.recentSearches);
}
class AddRecentSearchesEvent extends RecentSearchState {
  final String query;

  AddRecentSearchesEvent(this.query);
}