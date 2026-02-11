import 'package:fpdart/fpdart.dart';
import 'package:mini_product_showcase_app/core/error/failure.dart';
import 'package:mini_product_showcase_app/core/usecases/usecase.dart';
import 'package:mini_product_showcase_app/features/products/domain/entities/product.dart';
import 'package:mini_product_showcase_app/features/products/domain/repositories/product_repository.dart';

class ToggleFavorite implements UseCase<void, Product> {
  final ProductRepository repository;
  ToggleFavorite({required this.repository});
  @override
  Future<Either<Failure, void>> call(Product product) async {
    return await repository.toggleFavorite(product);
  }
}
