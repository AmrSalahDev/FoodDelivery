import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/di/di.dart';
import 'package:food_delivery/core/routes/args/home_screen_args.dart';
import 'package:food_delivery/core/routes/args/verification_screen_args.dart';
import 'package:food_delivery/features/access_location/ui/screens/access_location_screen.dart';
import 'package:food_delivery/features/forget_password/ui/screens/forget_password_screen.dart';
import 'package:food_delivery/features/home/ui/screens/home_screen.dart';
import 'package:food_delivery/features/login/ui/cubit/login_cubit.dart';
import 'package:food_delivery/features/login/ui/screens/login_screen.dart';
import 'package:food_delivery/features/onboarding/ui/screens/on_boarding_screen.dart';
import 'package:food_delivery/features/register/ui/cubit/register_cubit.dart';
import 'package:food_delivery/features/register/ui/screens/register_screen.dart';
import 'package:food_delivery/features/verification_password/ui/screens/verification_password_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppPaths {
  static const String onBoarding = '/onBoarding';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = "/forgetPassword";
  static const String verificationPassword = "/verificationPassword";
  static const String accessLocation = "/accessLocation";
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
          return HomeScreen(userLocation: 'Unknown Location');
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
