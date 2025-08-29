import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/app/widgets/custom_rectangle_button.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/features/onboarding/data/models/on_boarding_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late final PageController pageController;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(_handleOnPageChanged);
  }

  @override
  void dispose() {
    pageController.removeListener(_handleOnPageChanged);
    pageController.dispose();
    super.dispose();
  }

  _handleOnPageChanged() {
    setState(() {
      isLastPage = pageController.page == 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80.h),
                SizedBox(
                  height: 470.h,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: OnBoardingModel.onBoardingItems.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.asset(
                            OnBoardingModel.onBoardingItems[index].image,
                            width: 240.w,
                            height: 300.h,
                          ),
                          SizedBox(height: 30.h),
                          Text(
                            OnBoardingModel.onBoardingItems[index].title,
                            style: GoogleFonts.sen(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            OnBoardingModel.onBoardingItems[index].description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              color: AppColors.textGray,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  effect: WormEffect(
                    dotWidth: 10.w,
                    dotHeight: 10.h,
                    dotColor: AppColors.unSelectedDot,
                    activeDotColor: AppColors.secondary,
                  ),
                  onDotClicked: (index) {},
                ),

                SizedBox(height: isLastPage ? 100.h : 50.h),

                if (isLastPage)
                  CustomRectangleButton(
                    onPressed: () {
                      context.push(AppPaths.login);
                    },
                    title: AppStrings.getStarted,
                    backgroundColor: AppColors.secondary,
                    textStyle: GoogleFonts.sen(
                      fontSize: 14.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (!isLastPage)
                  Column(
                    children: [
                      CustomRectangleButton(
                        title: AppStrings.next,
                        onPressed: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        backgroundColor: AppColors.secondary,
                        textStyle: GoogleFonts.sen(
                          fontSize: 14.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CustomRectangleButton(
                        title: AppStrings.skip,
                        onPressed: () {
                          context.push(AppPaths.login);
                        },
                        backgroundColor: AppColors.primary,
                        textStyle: GoogleFonts.sen(
                          fontSize: 14.sp,
                          color: AppColors.textGray,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
