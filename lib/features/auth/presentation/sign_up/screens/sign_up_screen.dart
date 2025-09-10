import 'package:ecommerce_app/core/alerts/alert.dart';
import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/routes/router_constants.dart';
import 'package:ecommerce_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_app/core/widgets/text_field_widget.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState?.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthErrorState) {
              alert('Error', state.message.message, ToastificationType.error);
            }
            if (state is Authenticated) {
              context.goNamed(RouterConstants.mainScreen);
            }
          },
          builder: (context, state) {
            return Center(
              child: SizedBox(
                width: kIsWeb ? 500 : double.infinity,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 3,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create an account',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'Let\'s create an account.',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        k10H,
                        Text(
                          'Full Name',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextFieldWidget(
                          title: 'Enter your Full Name',
                          controller: _fullNameController,
                          validator: (value) {
                            if (value == null || value.toString().isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        k10H,
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextFieldWidget(
                          title: 'Enter your email address',
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.toString().isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(
                              r'^[^@]+@[^@]+\.[^@]+',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        k10H,
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextFieldWidget(
                          title: 'Enter your Password',
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.toString().isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'By signing up you agree to our ',
                            style: TextStyle(fontSize: 15),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                text: 'Terms',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 1.5,
                                ),
                              ),
                              TextSpan(text: ', '),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 1.5,
                                ),
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                text: 'Cookie Policy.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        k10H,
                        RoundedButton(
                          title: 'Sign Up',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthSignUpRequested(
                                  fullName: _fullNameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                            }
                          },
                        ),
                        k10H,
                        Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Already have an account? ',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.pushNamed(
                                        RouterConstants.loginScreen,
                                      );
                                    },
                                  text: 'Log In',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
