part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchProductsEvent extends ProductEvent {}

class FetchProductByCategory extends ProductEvent {
  final String category;

  FetchProductByCategory({required this.category});
}
