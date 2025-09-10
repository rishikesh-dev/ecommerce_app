import 'package:ecommerce_app/core/routes/router_constants.dart';
import 'package:ecommerce_app/features/account/presentation/screens/account_screen.dart';
import 'package:ecommerce_app/features/account/presentation/screens/address_book/screens/add_new_address_screen.dart';
import 'package:ecommerce_app/features/account/presentation/screens/address_book/screens/address_book_screen.dart';
import 'package:ecommerce_app/features/account/presentation/screens/help_center/help_center_screen.dart';
import 'package:ecommerce_app/features/account/presentation/screens/help_center/screens/customer_service.dart';
import 'package:ecommerce_app/features/account/presentation/screens/my_details/my_details_screen.dart';
import 'package:ecommerce_app/features/account/presentation/screens/my_orders/my_orders_screen.dart';
import 'package:ecommerce_app/features/account/presentation/screens/my_orders/screens/tracking_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/reset_password/screens/reset_passwords_screens.dart';
import 'package:ecommerce_app/features/auth/presentation/sign_in/screens/sign_in_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/sign_up/screens/sign_up_screen.dart';
import 'package:ecommerce_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:ecommerce_app/features/checkout/domain/entities/order_entity.dart';
import 'package:ecommerce_app/features/checkout/presentation/screens/check_out_screen.dart';
import 'package:ecommerce_app/features/details/presentation/screens/details_screen.dart';
import 'package:ecommerce_app/features/home/presentation/screens/home_screen.dart';
import 'package:ecommerce_app/features/saved/presentation/screens/saved_screen.dart';
import 'package:ecommerce_app/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoRouter goRoute = GoRouter(
    redirect: (context, state) {
      final user = _auth.currentUser;
      final publicPaths = ['/login', '/signup', '/reset'];

      // Authenticated users → block access to auth screens
      if (user != null &&
          publicPaths.any((path) => state.matchedLocation.startsWith(path))) {
        return '/';
      }

      // Unauthenticated users → block access to private screens
      if (user == null &&
          !publicPaths.any((path) => state.matchedLocation.startsWith(path))) {
        return '/login';
      }

      return null; // stay on current route
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
        path: '/cart',
        name: RouterConstants.cartScreen,
        builder: (context, state) => const CartScreen(),
      ),

      GoRoute(
        path: '/account',
        name: RouterConstants.accountScreen,
        builder: (context, state) => const AccountScreen(),
      ),
      GoRoute(
        path: '/saved',
        name: RouterConstants.savedScreen,
        builder: (context, state) => const SavedScreen(),
      ),

      GoRoute(
        path: '/details/:id',
        name: RouterConstants.detailsScreen,
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return DetailsScreen(id: id);
        },
      ),
      GoRoute(
        path: '/checkout',
        name: RouterConstants.checkOutScreen,

        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;

          return CheckOutScreen(
            subtotal: extras?['subtotal'],
            vat: extras?['vat'],
            shippingFee: extras?['shippingFee'],
            total: extras?['total'],
            productEntity: extras?['products'],
          );
        },
      ),
      GoRoute(
        path: '/mydetails',
        name: RouterConstants.myDetailsScreen,
        builder: (context, state) {
          return MyDetailsScreen();
        },
      ),
      GoRoute(
        path: '/myOrder',
        name: RouterConstants.myOrdersScreen,
        builder: (context, state) => const MyOrdersScreen(),
      ),
      GoRoute(
        path: '/address',
        name: RouterConstants.myAddressesScreen,
        builder: (context, state) => const AddressBookScreen(),
      ),
      GoRoute(
        path: '/newaddress',
        name: RouterConstants.addNewAddressScreen,

        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;
          return AddNewAddressScreen(
            id: extras?['id'],
            country: extras?['country'],
            state: extras?['state'],
            fullName: extras?['fullName'],
            buildingNo: extras?['buildingNo'],
            landMark: extras?['landMark'],
            area: extras?['area'],
            town: extras?['town'],
            mobileNo: extras?['mobileNo'],
            pincode: extras?['pincode'],
            isDefault: extras?['isDefault'],
          );
        },
      ),

      GoRoute(
        path: '/help',
        name: RouterConstants.helpCenterScreen,
        builder: (context, state) => const HelpCenterScreen(),
      ),
      GoRoute(
        path: '/customerService',
        name: RouterConstants.customerServiceScreen,
        builder: (context, state) => const CustomerService(),
      ),
      GoRoute(
        path: '/track',
        name: RouterConstants.trackOrderScreen,
        builder: (context, state) {
          final order = state.extra as OrderEntity;
          return OrderTrackingScreen(order: order);
        },
      ),
    ],
  );
}
