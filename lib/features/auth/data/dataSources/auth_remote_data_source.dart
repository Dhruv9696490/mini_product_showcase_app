import 'package:mini_product_showcase_app/core/error/exception.dart';
import 'package:mini_product_showcase_app/features/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<UserModel> signIn({required String email, required String password});

  Future<void> signOut();

}

class AuthRemoteDataSourceImple implements AuthRemoteDataSource {
  AuthRemoteDataSourceImple();

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      if (email.contains('@gmail.com') && password.length >= 6) {
        return UserModel(email: email, name: name, id: "3246832723",);
      }
      throw ServerException(
        error:  "email is badly formatted and password must be at least 6 characters long",
      );
    } catch (e) {
      throw ServerException(error: e.toString());
    }
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      if (email.contains('@gmail.com') && password.length >= 6) {
        return UserModel(email: email, name: 'Your ', id: "3246832723");
      }
      throw ServerException(
        error: "email is badly formatted and password must be at least 6 characters long",
      );
    } catch (e) {
      throw ServerException(error:  e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      throw ServerException(error:  e.toString());
    }
  }
}
