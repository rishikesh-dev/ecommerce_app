part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchProductsEvent extends ProductEvent {}
class FetchCategoriesEvent extends ProductEvent {}
