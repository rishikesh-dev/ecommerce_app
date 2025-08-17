part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchQueryChangedEvent extends SearchEvent {
  final String query;

  SearchQueryChangedEvent(this.query);
}

class SearchResultsClearEvent extends SearchEvent {}
