import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowOfferDialog {
  ShowOfferDialog._();

  static void showOfferDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      useSafeArea: false,
      barrierDismissible: true,
      barrierColor: Colors.black38,
      builder: (BuildContext dialogContext) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.black38,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),

          child: Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: 400.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFA500), Color(0xFFE76F00)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(35.r),
              ),
              padding: const EdgeInsets.all(20),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 30.h),
                      Text(
                        AppStrings.hurryOffers,
                        style: GoogleFonts.sen(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Text(
                        "#1243CD2",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sen(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        AppStrings.offerDescription,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sen(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(parentContext).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(double.infinity, 60.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          side: const BorderSide(color: Colors.white),
                        ),
                        child: Text(
                          AppStrings.gotIt.toUpperCase(),
                          style: GoogleFonts.sen(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Positioned(
                    top: -40,
                    right: -25,
                    child: IconButton.filled(
                      icon: Icon(
                        Icons.close,
                        color: Color(0xFFEF761A),
                        size: 20.h,
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color(0xFFFFE194),
                        ),
                        shape: WidgetStateProperty.all(const CircleBorder()),
                        minimumSize: WidgetStateProperty.all(Size(45.w, 45.h)),
                      ),
                      onPressed: () {
                        Navigator.of(parentContext).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
