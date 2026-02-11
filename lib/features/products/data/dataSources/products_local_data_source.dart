import 'package:hive/hive.dart';
import 'package:mini_product_showcase_app/features/products/data/models/product_local_model.dart';

abstract interface class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductLocalModel> products);

  Future<List<int>> getFavoriteIds();

  Future<List<ProductLocalModel>> getCachedProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Box box;

  ProductLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheProducts(List<ProductLocalModel> products) async {
    for (final product in products) {
      await box.put(product.id, product.toMap());
    }
  }

  @override
  Future<List<ProductLocalModel>> getCachedProducts() async {
    return box.values
        .map((e) => ProductLocalModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<List<int>> getFavoriteIds() async {
    final products = await getCachedProducts();

    return products
        .where((product) => product.isFavorite)
        .map((product) => product.id)
        .toList();
  }
}
