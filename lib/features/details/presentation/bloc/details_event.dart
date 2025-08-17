part of 'details_bloc.dart';

@immutable
sealed class DetailsEvent {}

class LoadDetailsEvent extends DetailsEvent {
  final int id;

  LoadDetailsEvent({required this.id});
}
