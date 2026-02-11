import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_product_showcase_app/core/theme/app_pallete.dart';
import 'package:mini_product_showcase_app/core/utils/loading.dart';
import 'package:mini_product_showcase_app/core/utils/show_message.dart';
import 'package:mini_product_showcase_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mini_product_showcase_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:mini_product_showcase_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:mini_product_showcase_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:mini_product_showcase_app/features/products/presentation/pages/bottom_naviagtion_bar.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (_) {
      return const LoginPage();
    },
  );
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder)=> const BottomNaviagtionBar()),
                (_)=> false
            );
          } else if (state is AuthFailure) {
            addMessage(context, state.error);
          }
        },
        builder: (BuildContext context, AuthState state) {
          if (state is AuthLoading) {
            return const ShowLoading();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    AuthField(controller: emailController, hintText: 'Email'),
                    const SizedBox(height: 15),
                    AuthField(
                      controller: passwordController,
                      hintText: 'Password',
                      isPassword: true,
                    ),
                    const SizedBox(height: 15),
                    AuthGradientButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          return BlocProvider.of<AuthBloc>(context).add(
                            LoginEvent(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                      title: 'Login',
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                        text: "Don't have account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: const TextStyle(color: AppPallete.gradient1),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  SignUpPage.route(),
                                  (_) => false,
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
