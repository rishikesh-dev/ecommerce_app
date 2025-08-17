part of 'saved_bloc.dart';

@immutable
sealed class SavedEvent {}

class GetSavedItemsEvent extends SavedEvent {}

class AddSavedItemEvent extends SavedEvent {
  final ProductEntity item;

  AddSavedItemEvent({required this.item});
}

class RemoveSavedItemsEvent extends SavedEvent {
  final ProductEntity item;

  RemoveSavedItemsEvent({required this.item});
}
