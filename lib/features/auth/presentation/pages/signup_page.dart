import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SingupPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SingupPage());
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _formKey.currentState?.validate();
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sign Up',
                    style:
                        TextStyle(fontSize: 43, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                AuthField(
                  hintText: 'Name',
                  controller: nameController,
                ),
                const SizedBox(height: 15),
                AuthField(
                  hintText: 'Email',
                  controller: emailController,
                ),
                const SizedBox(height: 15),
                AuthField(
                    hintText: 'Password',
                    controller: passwordController,
                    isObscureText: true),
                const SizedBox(height: 15),
                AuthGradientButton(
                  buttonText: ' Sign Up',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                            AuthSignUp(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    }
                  },
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      LoginPage.route(),
                    );
                  },
                  child: RichText(
                      text: TextSpan(
                          text: 'Already have an account?   ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                        TextSpan(
                          text: 'Sign In',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.bold,
                                  ),
                        )
                      ])),
                ),
              ],
            ),
          ),
        ));
  }
}
