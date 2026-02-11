
import 'package:fpdart/fpdart.dart';
import 'package:mini_product_showcase_app/core/error/failure.dart';

abstract interface class UseCase<Success,Params>{
  Future<Either<Failure,Success>> call(Params params);
}

class NoParam{}