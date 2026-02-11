part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}
final class ProductsLoaded extends ProductsState {
  final List<Product> list;
  ProductsLoaded(this.list);
}
final class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}
final class ProductsLoading extends ProductsState {}