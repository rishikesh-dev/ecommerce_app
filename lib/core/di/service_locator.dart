import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ecommerce_app/features/auth/data/data_source/remote_data_sources/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/log_out_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/sign_up_use_case.dart';

import 'package:ecommerce_app/features/cart/data/data_sources/remote_data_sources/cart_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/add_to_cart_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/get_all_carts_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/remove_from_cart_use_case.dart';

import 'package:ecommerce_app/features/home/data/data_sources/remote_data_sources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/home/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/home/domain/use_cases/fetch_product_use_case.dart';

import 'package:ecommerce_app/features/home/data/data_sources/remote_data_sources/category_remote_data_source.dart';
import 'package:ecommerce_app/features/home/data/repositories/category_repository_impl.dart';
import 'package:ecommerce_app/features/home/domain/use_cases/fetch_categories_use_case.dart';

import 'package:ecommerce_app/features/saved/data/data_sources/remote_data_sources/saved_remote_data_source.dart';
import 'package:ecommerce_app/features/saved/data/repositories/saved_repositories_impl.dart';
import 'package:ecommerce_app/features/saved/domain/use_cases/add_saved_items_use_case.dart';
import 'package:ecommerce_app/features/saved/domain/use_cases/get_saved_items_use_case.dart';
import 'package:ecommerce_app/features/saved/domain/use_cases/remove_saved_items_use_case.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // 🔹 Auth
  sl.registerLazySingleton(() => AuthRemoteDataSource(
        auth: sl(),
        firebaseFirestore: sl(),
      ));
  sl.registerLazySingleton(() => AuthRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton(() => SignInUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => LogOutUseCase(authRepository: sl()));

  // 🔹 Products
  sl.registerLazySingleton(() => ProductRemoteDataSource(baseUrl: 'https://dummyjson.com'));
  sl.registerLazySingleton(() => ProductRepositoryImpl(sl()));
  sl.registerLazySingleton(() => FetchProductUseCase(sl()));

  // 🔹 Categories
  sl.registerLazySingleton(() => CategoryRemoteDataSource(baseUrl: 'https://dummyjson.com'));
  sl.registerLazySingleton(() => CategoryRepositoryImpl(sl()));
  sl.registerLazySingleton(() => FetchCategoriesUseCase(sl()));

  // 🔹 Saved
  sl.registerLazySingleton(() => SavedRemoteDataSource(auth: sl(), firestore: sl()));
  sl.registerLazySingleton(() => SavedRepositoriesImpl(remoteDataSource: sl()));
  sl.registerLazySingleton(() => AddSavedItemsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetSavedItemsUseCase(repository: sl()));
  sl.registerLazySingleton(() => RemoveSavedItemsUseCase(repository: sl()));

  // 🔹 Cart
  sl.registerLazySingleton(() => CartRemoteDataSource(auth: sl(), firestore: sl()));
  sl.registerLazySingleton(() => CartRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllCartsUseCase(repository: sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(repository: sl()));
}
