import 'package:fpdart/fpdart.dart';
import 'package:mini_product_showcase_app/core/error/failure.dart';
import 'package:mini_product_showcase_app/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, void>> toggleFavorite(Product product);
}
