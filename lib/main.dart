import 'package:ecommerce_app/core/routes/router_config.dart';
import 'package:ecommerce_app/core/theme/app_theme.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/blocs/bloc/category_bloc/category_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/features/saved/presentation/blocs/bloc/saved_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

import 'core/di/service_locator.dart';

// Blocs

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // setup service locator
  await initDependencies();

  MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => AuthBloc(sl(), sl(), sl(), sl())),
      BlocProvider(create: (_) => ProductBloc(sl())),
      BlocProvider(create: (_) => CategoryBloc(sl())),
      BlocProvider(
        create: (_) => CartBloc(
          addToCartUseCase: sl(),
          removeFromCartUseCase: sl(),
          getAllCartsUseCase: sl(),
        ),
      ),
      BlocProvider(
        create: (_) => SavedBloc(
          addSavedItemsUseCase: sl(),
          getSavedItemsUseCase: sl(),
          removeSavedItemsUseCase: sl(),
        )..add(GetSavedItemsEvent()),
      ),
    ],
    child: MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ecommerce App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: AppRoute.goRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
