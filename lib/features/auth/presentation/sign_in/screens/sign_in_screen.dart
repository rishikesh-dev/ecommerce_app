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

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true),
      body: Center(
        child: SizedBox(
          width: kIsWeb ? 500 : double.infinity,
          child: SafeArea(
            minimum: EdgeInsets.all(20),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthErrorState) {
                  alert(
                    'Error',
                    state.message.message,
                    ToastificationType.error,
                  );
                }
                if (state is Authenticated) {
                  context.pushReplacementNamed(RouterConstants.mainScreen);
                }
              },
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 3,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Log In to your account',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'It\'s great to see you again.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                      k15H,
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
                        controller: _passwordController,
                        title: 'Enter your Password',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        helper: Align(
                          alignment: Alignment.centerRight,
                          child: Text.rich(
                            textAlign: TextAlign.end,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Forgot your password? ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.pushNamed(
                                        RouterConstants.resetPasswordScreen,
                                      );
                                    },
                                  text: 'Reset your password',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Theme.of(context).cardColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      k10H,
                      RoundedButton(
                        title: 'Log In',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              AuthSignInRequested(
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
                                text: 'Doesn\'t have an account? ',
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
                                    GoRouter.of(context).push('/signup');
                                  },
                                text: 'Join',
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
          ),
        ),
      ),
    );
  }
}
