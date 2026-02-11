
import 'package:fpdart/fpdart.dart';
import 'package:mini_product_showcase_app/core/common/entities/user.dart';
import 'package:mini_product_showcase_app/core/error/failure.dart';
import 'package:mini_product_showcase_app/core/usecases/usecase.dart';
import 'package:mini_product_showcase_app/features/auth/domain/repositories/auth_repository.dart';



class UserLogin implements UseCase<User,LoginParam>{
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, User>> call(LoginParam param) async{
       return await authRepository.loginWithEmailAndPassword(
           email: param.email, password: param.password);
  }
}



class LoginParam{
  final String email;
  final String password;
  LoginParam({required this.email, required this.password});
}