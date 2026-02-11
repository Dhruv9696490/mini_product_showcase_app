
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mini_product_showcase_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:mini_product_showcase_app/core/common/cubit/currentTheme/theme_cubit.dart';
import 'package:mini_product_showcase_app/core/network/connection_checker.dart';
import 'package:mini_product_showcase_app/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:mini_product_showcase_app/features/auth/data/repository/auth_repository_imple.dart';
import 'package:mini_product_showcase_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mini_product_showcase_app/features/auth/domain/usecases/log_out.dart';
import 'package:mini_product_showcase_app/features/auth/domain/usecases/user_login.dart';
import 'package:mini_product_showcase_app/features/auth/domain/usecases/user_signup.dart';
import 'package:mini_product_showcase_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mini_product_showcase_app/features/products/data/dataSources/product_remote_data_source.dart';
import 'package:mini_product_showcase_app/features/products/data/dataSources/products_local_data_source.dart';
import 'package:mini_product_showcase_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:mini_product_showcase_app/features/products/domain/repositories/product_repository.dart';
import 'package:mini_product_showcase_app/features/products/domain/usecases/get_products.dart';
import 'package:mini_product_showcase_app/features/products/domain/usecases/toggle_favorite.dart';
import 'package:mini_product_showcase_app/features/products/presentation/bloc/products_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await Hive.initFlutter();
  final productBox = await Hive.openBox('products');
  serviceLocator.registerFactory(() => InternetConnection());
  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerLazySingleton(() => ThemeCubit());

  serviceLocator.registerLazySingleton(() => productBox);
  serviceLocator.registerLazySingleton(() => Client());

  _initAuth();
  _initProductDependencies();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImple())
    ..registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImple(
        connectionChecker: serviceLocator<ConnectionChecker>(),
        authRemoteDataSource: serviceLocator<AuthRemoteDataSource>(),
      ),
    )
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(
      () => LogOut(authRepository: serviceLocator<AuthRepository>()),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator<UserSignUp>(),
        userLogin: serviceLocator<UserLogin>(),
        appUserCubit: serviceLocator<AppUserCubit>(),
        logOut: serviceLocator<LogOut>(),
      ),
    );
}

void _initProductDependencies() {
  serviceLocator
    ..registerFactory<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<ProductRepository>(
      () => ProductRepositoryImpl(
        localDataSource: serviceLocator<ProductLocalDataSource>(),
        remoteDataSource: serviceLocator<ProductRemoteDataSource>(),
        connectionChecker: serviceLocator<ConnectionChecker>(),
      ),
    )
    ..registerFactory(
      () => GetProducts(repository: serviceLocator<ProductRepository>()),
    )
    ..registerFactory(
      () => ToggleFavorite(repository: serviceLocator<ProductRepository>()),
    )
    ..registerLazySingleton(
      () => ProductsBloc(getProducts: serviceLocator(), toggleFavorite: serviceLocator()),
    );
}
