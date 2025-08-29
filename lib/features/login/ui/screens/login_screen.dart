import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/app/widgets/custom_checkbox.dart';
import 'package:food_delivery/app/widgets/custom_divider.dart';
import 'package:food_delivery/app/widgets/custom_rectangle_button.dart';
import 'package:food_delivery/app/widgets/custom_textfield.dart';
import 'package:food_delivery/app/widgets/social_circle_button.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/di/di.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/services/toast_service.dart';
import 'package:food_delivery/features/login/ui/cubit/login_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/utils/validators.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> emailFormKey;
  late final GlobalKey<FormState> passwordFormKey;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFormKey = GlobalKey<FormState>();
    passwordFormKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                context.go(AppPaths.accessLocation);
              }
              if (state is LoginFailure) {
                getIt<ToastService>().showErrorToast(
                  context: context,
                  message: state.message,
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.login,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sen(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        AppStrings.loginDescription,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sen(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
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
                        right: 20.w,
                        left: 20.w,
                        top: 20.h,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextfield(
                              controller: emailController,
                              formKey: emailFormKey,
                              validator: (value) => Validators.email(value),
                              hint: AppStrings.emailHint,
                              textInputType: TextInputType.emailAddress,
                              label: AppStrings.email.toUpperCase(),
                            ),
                            CustomTextfield(
                              controller: passwordController,
                              isPassword: true,
                              validator: (value) => Validators.password(value),
                              formKey: passwordFormKey,
                              hint: AppStrings.passwordHint,
                              textInputType: TextInputType.visiblePassword,
                              label: AppStrings.password.toUpperCase(),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                CustomCheckbox(onChange: (value) {}),
                                SizedBox(width: 10.w),
                                Text(
                                  AppStrings.rememberMe,
                                  style: GoogleFonts.sen(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    color: const Color(0xFF7E8A97),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    context.push(AppPaths.forgetPassword);
                                  },
                                  child: Text(
                                    AppStrings.forgotPassword,
                                    style: GoogleFonts.sen(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30.h),
                            BlocSelector<LoginCubit, LoginState, bool>(
                              selector: (state) {
                                return state is LoginLoading;
                              },
                              builder: (context, state) {
                                return CustomRectangleButton(
                                  title: AppStrings.login.toUpperCase(),
                                  titleColor: AppColors.white,
                                  isLoading: state,
                                  onPressed: () {
                                    if (emailFormKey.currentState!.validate() &&
                                        passwordFormKey.currentState!
                                            .validate()) {
                                      context.read<LoginCubit>().login(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  backgroundColor: AppColors.secondary,
                                );
                              },
                            ),
                            SizedBox(height: 20.h),
                            Center(
                              child: Text.rich(
                                TextSpan(
                                  text: AppStrings.dontHaveAccount,
                                  style: GoogleFonts.sen(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    color: const Color(0xFF646982),
                                  ),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context.push(AppPaths.register);
                                        },
                                      text: AppStrings.signUp.toUpperCase(),
                                      style: GoogleFonts.sen(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            CustomDivider(
                              title: AppStrings.or.toUpperCase(),
                              color: Colors.grey.shade300,
                              textStyle: const TextStyle(
                                color: Color(0xFF646982),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SocialCircleButton(
                                  height: 62.h,
                                  width: 62.w,
                                  onTap: () {},
                                  icon: FaIcon(
                                    FontAwesomeIcons.facebookF,
                                    color: Colors.white,
                                    size: 24.h,
                                  ),
                                  color: AppColors.facebook,
                                ),
                                SocialCircleButton(
                                  height: 62.h,
                                  width: 62.w,
                                  onTap: () {},
                                  icon: FaIcon(
                                    FontAwesomeIcons.twitter,
                                    color: Colors.white,
                                    size: 24.h,
                                  ),
                                  color: AppColors.twitter,
                                ),
                                SocialCircleButton(
                                  height: 62.h,
                                  width: 62.w,
                                  onTap: () {},
                                  icon: FaIcon(
                                    FontAwesomeIcons.apple,
                                    color: Colors.white,
                                    size: 24.h,
                                  ),
                                  color: AppColors.apple,
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
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
      ),
    );
  }
}
