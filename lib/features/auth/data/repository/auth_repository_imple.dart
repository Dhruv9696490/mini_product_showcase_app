import 'package:fpdart/fpdart.dart';
import 'package:mini_product_showcase_app/core/common/entities/user.dart';
import 'package:mini_product_showcase_app/core/constant/constant.dart';
import 'package:mini_product_showcase_app/core/error/exception.dart';
import 'package:mini_product_showcase_app/core/error/failure.dart';
import 'package:mini_product_showcase_app/core/network/connection_checker.dart';
import 'package:mini_product_showcase_app/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:mini_product_showcase_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImple implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImple({
    required this.connectionChecker,
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, void>> logOut({required String userId}) async {
    if (!(await connectionChecker.isConnected)) {
      return left(
        Failure(
          Constant.offlineMessage
        ),
      );
    }
    try {
      authRemoteDataSource.signOut;
      return right(null);
    }on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (!(await connectionChecker.isConnected)) {
         return right(
       User(id: '488484', email: email, name: 'Your Name')
      );
      }
      final user = await authRemoteDataSource.signIn(
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (!(await connectionChecker.isConnected)) {
        return right(
       User(id: '488484', email: email, name: name)
      );
      }
      final user = await authRemoteDataSource.signUp(
        email: email,
        password: password,
        name: name,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }
  

}
