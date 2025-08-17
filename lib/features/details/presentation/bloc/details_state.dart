part of 'details_bloc.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  final DetailsEntity details;

  DetailsLoaded({required this.details});
}

class DetailsError extends DetailsState {
  final String message;

  DetailsError({required this.message});
}
