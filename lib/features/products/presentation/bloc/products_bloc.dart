import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_product_showcase_app/core/usecases/usecase.dart';
import 'package:mini_product_showcase_app/features/products/domain/entities/product.dart';
import 'package:mini_product_showcase_app/features/products/domain/usecases/get_products.dart';
import 'package:mini_product_showcase_app/features/products/domain/usecases/toggle_favorite.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts _getProducts;
  final ToggleFavorite _toggleFavorite;
  ProductsBloc({
    required GetProducts getProducts,
    required ToggleFavorite toggleFavorite,
  }) : _getProducts = getProducts,
       _toggleFavorite = toggleFavorite,
       super(ProductsInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductsLoading());
      final res = await _getProducts(NoParam());
      res.fold((l) => emit(ProductsError(l.error)), (r) {
        emit(ProductsLoaded(r));
      });
    });
    on<ToggleFavoriteEvent>((event, emit) async {
      if (state is ProductsLoaded) {
        final currentState = state as ProductsLoaded;

        final res = await _toggleFavorite(event.product);

        res.fold((l) => emit(ProductsError(l.error)), (_) {
          final updatedProducts = currentState.list.map((product) {
            if (product.id == event.product.id) {
              return product.copyWith(isFavorite: !product.isFavorite);
            }
            return product;
          }).toList();

          emit(ProductsLoaded(updatedProducts));
        });
      }
    });
  }
}
