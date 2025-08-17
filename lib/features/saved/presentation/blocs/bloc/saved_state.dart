part of 'saved_bloc.dart';

@immutable
sealed class SavedState {}

final class SavedInitial extends SavedState {}

class SavedItemsLoading extends SavedState {}

class SavedItemsLoaded extends SavedState {
  final List<ProductEntity> products;

  SavedItemsLoaded({required this.products});
}

class SavedItemsError extends SavedState {
  final String message;

  SavedItemsError({required this.message});
}
