import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/di/di.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: ".env");

  configureDependencies();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  if (kReleaseMode) {
    await SentryFlutter.init(
      (options) {
        options.dsn = dotenv.env['SENTRY_DSN'];
        options.sendDefaultPii = true;
      },
      appRunner: () {
        runApp(SentryWidget(child: const DeliveryApp()));
        FlutterNativeSplash.remove();
      },
    );
  } else {
    runApp(const DeliveryApp());
    FlutterNativeSplash.remove();
  }
}

class DeliveryApp extends StatelessWidget {
  const DeliveryApp({super.key});
  @override
  Widget build(BuildContext context) {
    /// Set default transition values for all `GoTransition`.
    GoTransition.defaultCurve = Curves.easeInOut;
    GoTransition.defaultDuration = const Duration(milliseconds: 400);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: SystemUIWrapper(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
        navigationBarColor: AppColors.white,
        navigationBarIconBrightness: Brightness.dark,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: GoTransitions.fadeUpwards,
                TargetPlatform.iOS: GoTransitions.cupertino,
                TargetPlatform.macOS: GoTransitions.cupertino,
              },
            ),
            scaffoldBackgroundColor: AppColors.white,
            primaryColor: AppColors.white,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: AppColors.secondary,
              selectionColor: AppColors.secondary.withAlpha(40),
              selectionHandleColor: AppColors.secondary,
            ),
          ),
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
