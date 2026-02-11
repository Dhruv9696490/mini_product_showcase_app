
import 'package:fpdart/fpdart.dart';
import 'package:mini_product_showcase_app/core/error/failure.dart';
import 'package:mini_product_showcase_app/core/usecases/usecase.dart';
import 'package:mini_product_showcase_app/features/auth/domain/repositories/auth_repository.dart';


class LogOut implements UseCase<void, String> {
  final AuthRepository authRepository;

  LogOut({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(String userId) async{
    return await authRepository.logOut(userId: userId);
  }
}
