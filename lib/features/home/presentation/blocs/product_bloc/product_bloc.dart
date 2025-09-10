import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/features/home/domain/use_cases/fetch_product_by_category_use_case.dart';
import 'package:ecommerce_app/features/home/domain/use_cases/fetch_product_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FetchProductUseCase productUseCase;
  final FetchProductByCategoryUseCase productByCategoryUseCase;
  ProductBloc(this.productUseCase, this.productByCategoryUseCase)
    : super(ProductInitial()) {
    on<FetchProductsEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await productUseCase();
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (products) => emit(ProductLoaded(products)),
      );
    });
    on<FetchProductByCategory>((event, emit) async {
      emit(ProductLoading());
      final result = await productByCategoryUseCase(event.category);
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (product) => emit(ProductLoaded(product)),
      );
    });
  }
}
