import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/shared/widgets/custom_rectangle_button.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/di/di.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/home_screen_args.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_delivery/core/services/location_service.dart';

class AccessLocationScreen extends StatefulWidget {
  const AccessLocationScreen({super.key});

  @override
  State<AccessLocationScreen> createState() => _AccessLocationScreenState();
}

class _AccessLocationScreenState extends State<AccessLocationScreen> {
  bool _isLoading = false;
  String? userLocation = '';

  Future<void> _getLocation() async {
    setState(() => _isLoading = true);
    await getIt<LocationService>().ensureServiceEnabled();
    userLocation = await getIt<LocationService>().getCurrentAddress();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.images.locationAccess.path,
                  width: 300.w,
                  height: 300.h,
                ),
                SizedBox(height: 30.h),

                SizedBox(height: 30.h),
                CustomRectangleButton(
                  height: 62.h,
                  isLoading: _isLoading,
                  onPressed: () async {
                    await _getLocation();
                    if (context.mounted) {
                      context.push(
                        AppPaths.home,
                        extra: HomeScreenArgs(userLocation: userLocation),
                      );
                    }
                  },
                  backgroundColor: AppColors.secondary,
                  titleWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.accessLocation.toUpperCase(),
                        style: GoogleFonts.sen(
                          color: AppColors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white24,
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  AppStrings.accessLocationDescription,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sen(
                    color: Color(0xFF646982),
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
