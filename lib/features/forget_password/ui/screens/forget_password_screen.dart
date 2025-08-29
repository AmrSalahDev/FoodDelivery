import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/app/widgets/custom_back_button.dart';
import 'package:food_delivery/app/widgets/custom_rectangle_button.dart';
import 'package:food_delivery/app/widgets/custom_textfield.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/verification_screen_args.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final TextEditingController emailController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SystemUIWrapper(
      statusBarColor: const Color(0xFF1E1E2E),
      statusBarIconBrightness: Brightness.light,
      navigationBarColor: AppColors.white,
      navigationBarIconBrightness: Brightness.dark,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFF1E1E2E),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 220.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomBackButton(),
                    SizedBox(height: 15.h),
                    Text(
                      AppStrings.forgotPasswordTitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sen(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      AppStrings.forgotPasswordDescription,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sen(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFFFF2E0),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 25.w,
                      left: 25.w,
                      top: 35.h,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextfield(
                            controller: emailController,
                            formKey: formKey,
                            hint: AppStrings.emailHint,
                            textInputType: TextInputType.emailAddress,
                            label: AppStrings.email.toUpperCase(),
                          ),

                          CustomRectangleButton(
                            title: AppStrings.sendCode.toUpperCase(),
                            titleColor: AppColors.white,
                            onPressed: () {
                              context.push(
                                AppPaths.verificationPassword,
                                extra: VerificationScreenArgs(
                                  email: emailController.text.trim(),
                                ),
                              );
                            },
                            backgroundColor: AppColors.secondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
