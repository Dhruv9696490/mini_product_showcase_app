import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_product_showcase_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:mini_product_showcase_app/core/common/cubit/currentTheme/theme_cubit.dart';
import 'package:mini_product_showcase_app/core/theme/app_theme.dart';
import 'package:mini_product_showcase_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mini_product_showcase_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:mini_product_showcase_app/features/products/presentation/pages/bottom_naviagtion_bar.dart';
import 'package:mini_product_showcase_app/init_dependency.dart';

import 'features/products/presentation/bloc/products_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<ThemeCubit>()),
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<ProductsBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeCubit, ThemeState, bool>(
      selector: (state) {
        return state.isDark;
      },
      builder: (context, isDark) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          home: BlocSelector<AppUserCubit, AppUserState, bool>(
            selector: (state) {
              return state is AppUserLoggedIn;
            },
            builder: (context, isLoggedIn) {
              if (isLoggedIn) {
                return const BottomNaviagtionBar();
              }
              return const SignUpPage();
            },
          ),
        );
      },
    );
  }
}
