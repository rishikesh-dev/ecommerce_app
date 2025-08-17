import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/features/saved/domain/use_cases/add_saved_items_use_case.dart';
import 'package:ecommerce_app/features/saved/domain/use_cases/get_saved_items_use_case.dart';
import 'package:ecommerce_app/features/saved/domain/use_cases/remove_saved_items_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final GetSavedItemsUseCase getSavedItemsUseCase;
  final RemoveSavedItemsUseCase removeSavedItemsUseCase;
  final AddSavedItemsUseCase addSavedItemsUseCase;
  SavedBloc({
    required this.getSavedItemsUseCase,
    required this.removeSavedItemsUseCase,
    required this.addSavedItemsUseCase,
  }) : super(SavedInitial()) {
    on<GetSavedItemsEvent>((event, emit) async {
      emit(SavedItemsLoading());
      final result = await getSavedItemsUseCase();
      result.fold(
        (failure) => emit(SavedItemsError(message: failure.message)),
        (products) => emit(SavedItemsLoaded(products: products)),
      );
    });
    on<AddSavedItemEvent>((event, emit) async {
      final result = await addSavedItemsUseCase(event.item);
      result.fold(
        (failure) => emit(SavedItemsError(message: failure.message)),
        (product) {
          if (state is SavedItemsLoaded) {
            emit(
              SavedItemsLoaded(
                products: [...(state as SavedItemsLoaded).products, product],
              ),
            );
          } else {
            // First item case
            emit(SavedItemsLoaded(products: [product]));
          }
        },
      );
    });
    on<RemoveSavedItemsEvent>((event, emit) async {
      if (state is SavedItemsLoaded) {
        final currentProducts = List<ProductEntity>.from(
          (state as SavedItemsLoaded).products,
        );

        currentProducts.removeWhere((item) => item.id == event.item.id);

        emit(SavedItemsLoaded(products: currentProducts));
      }
    });
  }
}
