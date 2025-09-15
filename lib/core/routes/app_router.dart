import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/routes/args/add_card_screen_args.dart';
import 'package:food_delivery/core/routes/args/payment_screen_args.dart';
import 'package:food_delivery/features/cart/ui/cubits/cart_cubit.dart';
import 'package:food_delivery/features/cart/ui/cubits/cart_edit_address_cubit.dart';
import 'package:food_delivery/features/cart/ui/cubits/cart_edit_items_cubit.dart';
import 'package:food_delivery/features/cart/ui/screens/cart_screen.dart';
import 'package:food_delivery/features/home/ui/cubit/home_category_cubit.dart';
import 'package:food_delivery/features/payment/ui/cubits/card_cubit.dart';
import 'package:food_delivery/features/payment/ui/cubits/selected_card_cubit.dart';
import 'package:food_delivery/features/payment/ui/screens/add_card_screen.dart';
import 'package:food_delivery/features/payment/ui/screens/payment_screen.dart';
import 'package:food_delivery/features/payment/ui/screens/payment_success_screen.dart';
import 'package:food_delivery/features/restaurant_details/ui/cubit/restaurant_cubit.dart';
import 'package:food_delivery/features/search/ui/cubit/recent_keywords_cubit.dart';
import 'package:food_delivery/features/search/ui/cubit/search_cubit.dart';
import 'package:food_delivery/shared/cubits/food_cubit.dart';
import 'package:food_delivery/core/di/di.dart';
import 'package:food_delivery/core/routes/args/food_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/restaurant_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/search_result_screen_args.dart';
import 'package:food_delivery/core/routes/args/verification_screen_args.dart';
import 'package:food_delivery/features/access_location/ui/screens/access_location_screen.dart';
import 'package:food_delivery/features/food_details/ui/screens/food_details_screen.dart';
import 'package:food_delivery/features/forget_password/ui/screens/forget_password_screen.dart';
import 'package:food_delivery/features/home/ui/cubit/home_cubit.dart';
import 'package:food_delivery/features/home/ui/screens/home_screen.dart';
import 'package:food_delivery/features/search/ui/screens/search_result_screen.dart';
import 'package:food_delivery/features/search/ui/screens/search_screen.dart';
import 'package:food_delivery/features/login/ui/cubit/login_cubit.dart';
import 'package:food_delivery/features/login/ui/screens/login_screen.dart';
import 'package:food_delivery/features/onboarding/ui/screens/on_boarding_screen.dart';
import 'package:food_delivery/features/register/ui/cubit/register_cubit.dart';
import 'package:food_delivery/features/register/ui/screens/register_screen.dart';
import 'package:food_delivery/features/restaurant_details/ui/screens/restaurant_details_screen.dart';
import 'package:food_delivery/features/verification_password/ui/screens/verification_password_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppPaths {
  static const String onBoarding = '/onBoarding';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = "/forgetPassword";
  static const String verificationPassword = "/verificationPassword";
  static const String accessLocation = "/accessLocation";
  static const String search = "/search";
  static const String searchResult = "/searchResult";
  static const String foodDetails = "/foodDetails";
  static const String restaurantDetails = "/restaurantDetails";
  static const String cart = "/cart";
  static const String payment = "/payment";
  static const String addCard = "/addCard";
  static const String paymentSuccess = "/paymentSuccess";
}

class SupabaseAuthNotifier extends ChangeNotifier {
  SupabaseAuthNotifier() {
    Supabase.instance.client.auth.onAuthStateChange.listen((_) {
      notifyListeners(); // update router on sign in/out
    });
  }
}

class AppRouter {
  static final router = GoRouter(
    refreshListenable: SupabaseAuthNotifier(),
    initialLocation: AppPaths.home,

    // redirect: (context, state) {
    //   if (!getIt<AuthService>().isUserLoggedIn()) {
    //     return AppPaths.onBoarding;
    //   } else {
    //     return AppPaths.home;
    //   }
    // },
    routes: [
      GoRoute(
        path: AppPaths.onBoarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: AppPaths.home,
        builder: (context, state) {
          //final args = state.extra as HomeScreenArgs;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<HomeCubit>()),
              BlocProvider(create: (context) => getIt<HomeCategoryCubit>()),
              BlocProvider(create: (context) => getIt<RestaurantCubit>()),
              BlocProvider.value(value: getIt<CartCubit>()),
            ],
            child: HomeScreen(userLocation: 'Unknown Location'),
          );
        },
      ),
      GoRoute(
        path: AppPaths.search,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<RestaurantCubit>()),
            BlocProvider(create: (context) => getIt<RecentKeywordsCubit>()),
            BlocProvider(create: (context) => getIt<SearchCubit>()),
            BlocProvider.value(value: getIt<CartCubit>()),
          ],
          child: SearchScreen(),
        ),
      ),
      GoRoute(
        path: AppPaths.payment,
        builder: (context, state) {
          final args = state.extra as PaymentScreenArgs;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<SelectedCardCubit>()),
              BlocProvider.value(value: getIt<CardCubit>()),
            ],
            child: PaymentScreen(totalPrice: args.totalPrice),
          );
        },
      ),
      GoRoute(
        path: AppPaths.paymentSuccess,
        builder: (context, state) => PaymentSuccessScreen(),
      ),
      GoRoute(
        path: AppPaths.addCard,
        builder: (context, state) {
          final args = state.extra as AddCardScreenArgs;
          return BlocProvider.value(
            value: getIt<CardCubit>(),
            child: AddCardScreen(cardType: args.cardType),
          );
        },
      ),
      GoRoute(
        path: AppPaths.cart,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: getIt<CartCubit>()),
            BlocProvider(create: (context) => getIt<CartEditItemsCubit>()),
            BlocProvider(create: (context) => getIt<CartEditAddressCubit>()),
          ],
          child: CartScreen(),
        ),
      ),
      GoRoute(
        path: AppPaths.searchResult,
        builder: (context, state) {
          final args = state.extra as SearchResultScreenArgs;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<FoodCubit>()),
              BlocProvider(create: (context) => getIt<RestaurantCubit>()),
              BlocProvider.value(value: getIt<CartCubit>()),
            ],
            child: SearchResultScreen(query: args.query),
          );
        },
      ),
      GoRoute(
        path: AppPaths.foodDetails,
        pageBuilder: GoTransitions.fade.call,
        builder: (context, state) {
          final args = state.extra as FoodDetailsScreenArgs;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<FoodCubit>()),
              BlocProvider.value(value: getIt<CartCubit>()),
            ],
            child: FoodDetailsScreen(foodModel: args.foodModel),
          );
        },
      ),
      GoRoute(
        path: AppPaths.restaurantDetails,
        pageBuilder: GoTransitions.fade.call,
        builder: (context, state) {
          final args = state.extra as RestaurantDetailsScreenArgs;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<FoodCubit>()),
              BlocProvider(create: (context) => getIt<RestaurantCubit>()),
            ],
            child: RestaurantDetailsScreen(
              restaurantEntity: args.restaurantEntity,
            ),
          );
        },
      ),

      GoRoute(
        path: AppPaths.login,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppPaths.forgetPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: AppPaths.verificationPassword,
        builder: (context, state) {
          final args = state.extra as VerificationScreenArgs;
          return VerificationPasswordScreen(email: args.email);
        },
      ),
      GoRoute(
        path: AppPaths.register,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<RegisterCubit>(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: AppPaths.accessLocation,
        builder: (context, state) => const AccessLocationScreen(),
      ),
    ],
  );
}
