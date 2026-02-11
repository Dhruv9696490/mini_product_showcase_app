part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

final class LoadProducts extends ProductsEvent {}

final class ToggleFavoriteEvent extends ProductsEvent {
  final Product product;
  ToggleFavoriteEvent({required this.product});
}
