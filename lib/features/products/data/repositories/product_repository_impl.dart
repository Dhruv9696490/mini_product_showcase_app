import 'package:fpdart/fpdart.dart';
import 'package:mini_product_showcase_app/core/error/exception.dart';
import 'package:mini_product_showcase_app/core/error/failure.dart';
import 'package:mini_product_showcase_app/core/network/connection_checker.dart';
import 'package:mini_product_showcase_app/features/products/data/dataSources/product_remote_data_source.dart';
import 'package:mini_product_showcase_app/features/products/data/dataSources/products_local_data_source.dart';
import 'package:mini_product_showcase_app/features/products/data/models/product_local_model.dart';
import 'package:mini_product_showcase_app/features/products/domain/entities/product.dart';
import 'package:mini_product_showcase_app/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final ConnectionChecker connectionChecker;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      if (await connectionChecker.isConnected) {
        final remoteModels = await remoteDataSource.getProducts();

        // 2️⃣ Get favorites from local
        final favoriteIds = await localDataSource.getFavoriteIds();

        // 3️⃣ Merge favorite flag
        final products = remoteModels.map((model) {
          final isFav = favoriteIds.contains(model.id);
          return model.copyWith(isFavorite: isFav);
        }).toList();

        // 4️⃣ Cache locally
        final localModels = products
            .map((e) => ProductLocalModel.fromEntity(e))
            .toList();

        await localDataSource.cacheProducts(localModels);

        return right(products);
      } else {
        final localProducts = await localDataSource.getCachedProducts();
        return right(localProducts);
      }
    } on ServerException catch (e) {
      return left(Failure(e.error));
    } catch (e) {
      return left(Failure("Unexpected error"));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(Product product) async {
    try {
      final updated = product.copyWith(
        isFavorite: !product.isFavorite,
      );

      final localModel = ProductLocalModel.fromEntity(updated);

      await localDataSource.cacheProducts([localModel]);

      return right(null);
    } catch (e) {
      return left(Failure("Failed to update favorite"));
    }
  }
}



