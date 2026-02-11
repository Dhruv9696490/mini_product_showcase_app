import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_product_showcase_app/core/theme/app_pallete.dart';
import 'package:mini_product_showcase_app/core/utils/loading.dart';
import 'package:mini_product_showcase_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mini_product_showcase_app/features/auth/presentation/pages/login_page.dart';
import 'package:mini_product_showcase_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:mini_product_showcase_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:mini_product_showcase_app/features/products/presentation/pages/bottom_naviagtion_bar.dart';

import '../../../../core/utils/show_message.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (_) {
      return const SignUpPage();
    },
  );
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    AuthField(controller: nameController, hintText: 'Name'),
                    const SizedBox(height: 15),
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
                          BlocProvider.of<AuthBloc>(context).add(
                            SignUpEvent(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                      title: 'Sign Up',
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                        text: "Already have account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: const TextStyle(color: AppPallete.gradient1),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  LoginPage.route(),
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
