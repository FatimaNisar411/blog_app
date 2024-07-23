// import 'package:blog_app/core/theme/app_pallete.dart';
// import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
// import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
// import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// class SingupPage extends StatefulWidget {
//   static route() => MaterialPageRoute(builder: (context) => const SingupPage());
//   const SingupPage({super.key});

//   @override
//   State<SingupPage> createState() => _SingupPageState();
// }

// class _SingupPageState extends State<SingupPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final nameController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     nameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // _formKey.currentState?.validate();
//     return Scaffold(
//         appBar: AppBar(),
//         body: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Sign Up',
//                     style:
//                         TextStyle(fontSize: 43, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 15),
//                 AuthField(
//                   hintText: 'Name',
//                   controller: nameController,
//                 ),
//                 const SizedBox(height: 15),
//                 AuthField(
//                   hintText: 'Email',
//                   controller: emailController,
//                 ),
//                 const SizedBox(height: 15),
//                 AuthField(
//                     hintText: 'Password',
//                     controller: passwordController,
//                     isObscureText: true),
//                 const SizedBox(height: 15),
//                 AuthGradientButton(
//                   buttonText: ' Sign Up',
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       context.read<AuthBloc>().add(
//                             AuthSignUp(
//                               name: nameController.text,
//                               email: emailController.text,
//                               password: passwordController.text,
//                             ),
//                           );
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       LoginPage.route(),
//                     );
//                   },
//                   child: RichText(
//                       text: TextSpan(
//                           text: 'Already have an account?   ',
//                           style: Theme.of(context).textTheme.titleMedium,
//                           children: [
//                         TextSpan(
//                           text: 'Sign In',
//                           style:
//                               Theme.of(context).textTheme.titleMedium?.copyWith(
//                                     color: AppPallete.gradient2,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                         )
//                       ])),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
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

  void _handleSignUp() {
    // Log user input values
    print('Sign Up Button Pressed');
    print('Name: ${nameController.text}');
    print('Email: ${emailController.text}');
    print('Password: ${passwordController.text}');

    if (_formKey.currentState!.validate()) {
      // Dispatch the AuthSignUp event
      context.read<AuthBloc>().add(
            AuthSignUp(
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text,
            ),
          );
    } else {
      print('Form is not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthFailure){
              showSnackBar(context, state.message);
            }
            else if(state is AuthSuccess){
              Navigator.pushNamedAndRemoveUntil(
                context,
                BlogPage.route(),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
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
                    buttonText: 'Sign Up',
                    onPressed: _handleSignUp,
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
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        ])),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
