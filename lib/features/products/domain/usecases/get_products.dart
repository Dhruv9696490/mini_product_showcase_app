import 'package:fpdart/fpdart.dart';
import 'package:mini_product_showcase_app/core/error/failure.dart';
import 'package:mini_product_showcase_app/core/usecases/usecase.dart';
import 'package:mini_product_showcase_app/features/products/domain/entities/product.dart';
import 'package:mini_product_showcase_app/features/products/domain/repositories/product_repository.dart';

class GetProducts implements UseCase<List<Product>,NoParam> {
  final ProductRepository repository;
  GetProducts({required this.repository});
  @override
  Future<Either<Failure, List<Product>>> call(NoParam params) async{
    return await repository.getProducts();
  }
}