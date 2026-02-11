import 'package:fpdart/fpdart.dart';
import 'package:mini_product_showcase_app/core/common/entities/user.dart';
import 'package:mini_product_showcase_app/core/error/failure.dart';
import 'package:mini_product_showcase_app/core/usecases/usecase.dart';
import 'package:mini_product_showcase_app/features/auth/domain/repositories/auth_repository.dart';


class UserSignUp implements UseCase<User,SignUpParam>{
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(SignUpParam params)async{
    return await authRepository.signUpWithEmailAndPassword(name: params.name, email: params.email, password: params.password);
  }
}
class SignUpParam{
  final String name;
  final String email;
  final String password;
  SignUpParam({required this.name, required this.email, required this.password});
}