import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/push_notification/push_notification.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/address/update_address_use_case.dart';
import 'package:ecommerce_app/features/checkout/data/data_source/remote_data_source/payment_remote_data_source.dart';
import 'package:ecommerce_app/features/checkout/data/repositories/payment_repository_impl.dart';
import 'package:ecommerce_app/features/checkout/domain/use_cases/payments/make_payment_use_case.dart';
import 'package:ecommerce_app/features/checkout/presentation/bloc/payment/bloc/payment_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/core/routes/router_config.dart';
import 'package:ecommerce_app/core/theme/app_theme.dart';
import 'package:ecommerce_app/features/account/data/data_sources/address_remote_data_source.dart';
import 'package:ecommerce_app/features/account/data/data_sources/user_remote_data_source.dart';
import 'package:ecommerce_app/features/account/data/repositories/address_repository_impl.dart';
import 'package:ecommerce_app/features/account/data/repositories/user_repository_impl.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/address/add_address_use_case.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/address/delete_address_use_case.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/address/get_address_use_case.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/user/get_user_details_use_case.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/user/set_default_address_use_case.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/user/update_user_details_use_case.dart';
import 'package:ecommerce_app/features/account/presentation/blocs/address/bloc/address_bloc.dart';
import 'package:ecommerce_app/features/account/presentation/blocs/user/bloc/user_bloc.dart';
import 'package:ecommerce_app/features/auth/data/data_source/remote_data_sources/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/log_out_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/cart/data/data_sources/remote_data_sources/cart_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/add_to_cart_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/get_all_carts_use_case.dart';
import 'package:ecommerce_app/features/cart/domain/use_cases/remove_from_cart_use_case.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/checkout/data/data_source/remote_data_source/check_out_remote_data_source.dart';
import 'package:ecommerce_app/features/checkout/data/repositories/check_out_repository_impl.dart';
import 'package:ecommerce_app/features/checkout/domain/use_cases/fetch_orders_use_case.dart';
import 'package:ecommerce_app/features/checkout/domain/use_cases/place_order_use_case.dart';
import 'package:ecommerce_app/features/checkout/domain/use_cases/track_order_use_case.dart';
import 'package:ecommerce_app/features/checkout/presentation/bloc/check_out_bloc.dart';
import 'package:ecommerce_app/features/details/data/data_sources/remote_data_sources/details_remote_data_source.dart';
import 'package:ecommerce_app/features/details/data/repositories/details_repository_impl.dart';
import 'package:ecommerce_app/features/details/domain/use_cases/details_use_case.dart';
import 'package:ecommerce_app/features/details/presentation/bloc/details_bloc.dart';
import 'package:ecommerce_app/features/home/data/data_sources/remote_data_sources/category_remote_data_source.dart';
import 'package:ecommerce_app/features/home/data/data_sources/remote_data_sources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/home/data/repositories/category_repository_impl.dart';
import 'package:ecommerce_app/features/home/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/home/domain/use_cases/fetch_categories_use_case.dart';
import 'package:ecommerce_app/features/home/domain/use_cases/fetch_product_by_category_use_case.dart';
import 'package:ecommerce_app/features/home/domain/use_cases/fetch_product_use_case.dart';
import 'package:ecommerce_app/features/home/presentation/blocs/bloc/category_bloc/category_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/features/saved/data/data_sources/remote_data_sources/saved_remote_data_source.dart';
import 'package:ecommerce_app/features/saved/data/repositories/saved_repositories_impl.dart';
import 'package:ecommerce_app/features/saved/domain/use_cases/add_saved_items_use_case.dart';
import 'package:ecommerce_app/features/saved/domain/use_cases/get_saved_items_use_case.dart';
import 'package:ecommerce_app/features/saved/domain/use_cases/remove_saved_items_use_case.dart';
import 'package:ecommerce_app/features/saved/presentation/blocs/bloc/saved_bloc.dart';
import 'package:ecommerce_app/features/search/data/data_source/local_data_sources/local_recent_search_data_source.dart';
import 'package:ecommerce_app/features/search/data/data_source/remote_data_sources/search_remote_data_source.dart';
import 'package:ecommerce_app/features/search/data/repositories/recent_search_repository_impl.dart';
import 'package:ecommerce_app/features/search/data/repositories/search_repository_impl.dart';
import 'package:ecommerce_app/features/search/domain/use_cases/add_recent_search_use_case.dart';
import 'package:ecommerce_app/features/search/domain/use_cases/clear_recent_search_use_case.dart';
import 'package:ecommerce_app/features/search/domain/use_cases/load_recent_search_use_case.dart';
import 'package:ecommerce_app/features/search/domain/use_cases/search_use_case.dart';
import 'package:ecommerce_app/features/search/presentation/blocs/recent_search_bloc/bloc/recent_search_bloc.dart';
import 'package:ecommerce_app/features/search/presentation/blocs/search_blocs/bloc/search_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toastification/toastification.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final push = FirebaseMessaging.instance;
  await push.requestPermission(alert: true, badge: true, sound: true);
  final userId = FirebaseAuth.instance.currentUser!.uid;
  saveUserToken(userId);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            SignInUseCase(
              authRepository: AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSource(
                  auth: FirebaseAuth.instance,
                  firebaseFirestore: FirebaseFirestore.instance,
                ),
              ),
            ),
            SignUpUseCase(
              authRepository: AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSource(
                  auth: FirebaseAuth.instance,
                  firebaseFirestore: FirebaseFirestore.instance,
                ),
              ),
            ),
            ResetPasswordUseCase(
              authRepository: AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSource(
                  auth: FirebaseAuth.instance,
                  firebaseFirestore: FirebaseFirestore.instance,
                ),
              ),
            ),
            LogOutUseCase(
              authRepository: AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSource(
                  auth: FirebaseAuth.instance,
                  firebaseFirestore: FirebaseFirestore.instance,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ProductBloc(
            FetchProductUseCase(
              ProductRepositoryImpl(
                ProductRemoteDataSource(baseUrl: 'https://dummyjson.com'),
              ),
            ),
            FetchProductByCategoryUseCase(
              repository: ProductRepositoryImpl(
                ProductRemoteDataSource(baseUrl: 'https://dummyjson.com'),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => CategoryBloc(
            FetchCategoriesUseCase(
              CategoryRepositoryImpl(
                CategoryRemoteDataSource(baseUrl: 'https://dummyjson.com'),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => DetailsBloc(
            detailsUseCase: DetailsUseCase(
              detailsRepository: DetailsRepositoryImpl(
                remoteDataSource: DetailsRemoteDataSource(
                  baseUrl: 'https://dummyjson.com',
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => SearchBloc(
            SearchUseCase(
              SearchRepositoryImpl(
                remoteDataSource: SearchRemoteDataSource(
                  'https://dummyjson.com',
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => RecentSearchBloc(
            LoadRecentSearchUseCase(
              recentSearchRepository: RecentSearchRepositoryImpl(
                localDataSource: LocalRecentSearchesDataSource(),
              ),
            ),
            AddRecentSearchUseCase(
              RecentSearchRepositoryImpl(
                localDataSource: LocalRecentSearchesDataSource(),
              ),
            ),
            ClearRecentSearchUseCase(
              RecentSearchRepositoryImpl(
                localDataSource: LocalRecentSearchesDataSource(),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => CartBloc(
            addToCartUseCase: AddToCartUseCase(
              repository: CartRepositoryImpl(
                remoteDataSource: CartRemoteDataSource(
                  firestore: FirebaseFirestore.instance,
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
            removeFromCartUseCase: RemoveFromCartUseCase(
              repository: CartRepositoryImpl(
                remoteDataSource: CartRemoteDataSource(
                  firestore: FirebaseFirestore.instance,
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
            getAllCartsUseCase: GetAllCartsUseCase(
              repository: CartRepositoryImpl(
                remoteDataSource: CartRemoteDataSource(
                  firestore: FirebaseFirestore.instance,
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => SavedBloc(
            addSavedItemsUseCase: AddSavedItemsUseCase(
              repository: SavedRepositoriesImpl(
                remoteDataSource: SavedRemoteDataSource(
                  auth: FirebaseAuth.instance,
                  firestore: FirebaseFirestore.instance,
                ),
              ),
            ),
            getSavedItemsUseCase: GetSavedItemsUseCase(
              repository: SavedRepositoriesImpl(
                remoteDataSource: SavedRemoteDataSource(
                  auth: FirebaseAuth.instance,
                  firestore: FirebaseFirestore.instance,
                ),
              ),
            ),
            removeSavedItemsUseCase: RemoveSavedItemsUseCase(
              repository: SavedRepositoriesImpl(
                remoteDataSource: SavedRemoteDataSource(
                  auth: FirebaseAuth.instance,
                  firestore: FirebaseFirestore.instance,
                ),
              ),
            ),
          )..add(GetSavedItemsEvent()),
        ),
        BlocProvider(
          create: (_) => UserBloc(
            getUserDetailsUseCase: GetUserDetailsUseCase(
              userRepository: UserRepositoryImpl(
                remoteDataSource: UserRemoteDataSource(
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
            updateUserDetailsUseCase: UpdateUserDetailsUseCase(
              userRepository: UserRepositoryImpl(
                remoteDataSource: UserRemoteDataSource(
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => AddressBloc(
            addAddressUseCase: AddAddressUseCase(
              repository: AddressRepositoryImpl(
                remoteDataSource: AddressRemoteDataSource(
                  firestore: FirebaseFirestore.instance,
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
            updateAddressUseCase: UpdateAddressUseCase(
              addressRepository: AddressRepositoryImpl(
                remoteDataSource: AddressRemoteDataSource(
                  firestore: FirebaseFirestore.instance,
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
            getAddressUseCase: GetAddressUseCase(
              addressRepository: AddressRepositoryImpl(
                remoteDataSource: AddressRemoteDataSource(
                  firestore: FirebaseFirestore.instance,
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
            deleteAddressUseCase: DeleteAddressUseCase(
              addressRepository: AddressRepositoryImpl(
                remoteDataSource: AddressRemoteDataSource(
                  firestore: FirebaseFirestore.instance,
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
            setDefaultAddressUseCase: SetDefaultAddressUseCase(
              AddressRepositoryImpl(
                remoteDataSource: AddressRemoteDataSource(
                  firestore: FirebaseFirestore.instance,
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
          ),
        ),

        BlocProvider(
          create: (context) => CheckOutBloc(
            placeOrderUseCase: PlaceOrderUseCase(
              CheckOutRepositoryImpl(
                remoteDataSource: CheckOutRemoteDataSource(
                  firestore: FirebaseFirestore.instance,
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
            fetchOrdersUseCase: FetchOrdersUseCase(
              repository: CheckOutRepositoryImpl(
                remoteDataSource: CheckOutRemoteDataSource(
                  firestore: FirebaseFirestore.instance,
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
            trackOrderUseCase: TrackOrderUseCase(
              CheckOutRepositoryImpl(
                remoteDataSource: CheckOutRemoteDataSource(
                  firestore: FirebaseFirestore.instance,
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => PaymentBloc(
            makePaymentUseCase: MakePaymentUseCase(
              repository: PaymentRepositoryImpl(
                remoteDataSource: PaymentRemoteDataSource(
                  razorpay: Razorpay(),
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
          ),
        ),
      ],
      child: ToastificationWrapper(child: const MyApp()),
    ),
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
