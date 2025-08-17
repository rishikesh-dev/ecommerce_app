import 'package:ecommerce_app/core/routes/router_constants.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/reset_password/screens/reset_passwords_screens.dart';
import 'package:ecommerce_app/features/auth/presentation/sign_in/screens/sign_in_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/sign_up/screens/sign_up_screen.dart';
import 'package:ecommerce_app/features/details/presentation/screens/details_screen.dart';
import 'package:ecommerce_app/features/home/presentation/screens/home_screen.dart';
import 'package:ecommerce_app/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoRouter goRoute = GoRouter(
    redirect: (context, state) {
      final user = _auth.currentUser;
      if (user != null) {
        if (state.path == '/login' ||
            state.path == '/signup' ||
            state.path == '/reset') {
          return '/';
        }
      }
      // If not logged in → send to login
      if (user == null) {
        if (state.path == '/home' || state.path == '/details') {
          return '/login';
        }
      }

      // If already authenticated in bloc state → send to home
      final authState = context.read<AuthBloc>().state;
      if (authState is Authenticated) {
        return '/';
      }

      // Stay where you are
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: RouterConstants.mainScreen,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/reset',
        name: RouterConstants.resetPasswordScreen,
        builder: (context, state) => const ResetPasswordsScreens(),
      ),
      GoRoute(
        path: '/login',
        name: RouterConstants.loginScreen,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: RouterConstants.signupScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/home',
        name: RouterConstants.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/details/:id',
        name: RouterConstants.detailsScreen,
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return DetailsScreen(id: id);
        },
      ),
    ],
  );
}
