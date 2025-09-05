import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/shared/widgets/custom_back_button.dart';
import 'package:food_delivery/shared/widgets/custom_rectangle_button.dart';
import 'package:food_delivery/shared/widgets/custom_textfield.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/di/di.dart';
import 'package:food_delivery/core/services/toast_service.dart';
import 'package:food_delivery/features/register/ui/cubit/register_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/utils/validators.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final GlobalKey<FormState> nameFormKey;
  late final GlobalKey<FormState> emailFormKey;
  late final GlobalKey<FormState> passwordFormKey;
  late final GlobalKey<FormState> confirmPasswordFormKey;
  late final RegisterCubit registerCubit;

  @override
  void initState() {
    super.initState();
    registerCubit = getIt<RegisterCubit>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameFormKey = GlobalKey<FormState>();
    emailFormKey = GlobalKey<FormState>();
    passwordFormKey = GlobalKey<FormState>();
    confirmPasswordFormKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
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
          child: BlocListener<RegisterCubit, RegisterState>(
            bloc: registerCubit,
            listener: (context, state) {
              if (state is RegisterSuccess) {
                Navigator.pop(context);
              }
              if (state is RegisterFailure) {
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
                      CustomBackButton(),
                      SizedBox(height: 15.h),
                      Text(
                        AppStrings.signUp,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sen(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        AppStrings.signUpDescription,
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
                              controller: nameController,
                              formKey: nameFormKey,
                              hint: AppStrings.nameHint,
                              validator: (value) => Validators.name(value),
                              textInputType: TextInputType.name,
                              label: AppStrings.name.toUpperCase(),
                            ),
                            CustomTextfield(
                              controller: emailController,
                              formKey: emailFormKey,
                              hint: AppStrings.emailHint,
                              validator: (value) => Validators.email(value),
                              textInputType: TextInputType.emailAddress,
                              label: AppStrings.email.toUpperCase(),
                            ),
                            CustomTextfield(
                              controller: passwordController,
                              formKey: passwordFormKey,
                              isPassword: true,
                              validator: (value) => Validators.password(value),
                              hint: AppStrings.passwordHint,
                              textInputType: TextInputType.visiblePassword,
                              label: AppStrings.password.toUpperCase(),
                            ),
                            CustomTextfield(
                              controller: confirmPasswordController,
                              formKey: confirmPasswordFormKey,
                              validator: (value) {
                                if (value != passwordController.text) {
                                  return AppStrings.passwordNotMatch;
                                }
                                return null;
                              },
                              isPassword: true,
                              hint: AppStrings.confirmPassword,
                              textInputType: TextInputType.visiblePassword,
                              label: AppStrings.reTypePassword.toUpperCase(),
                            ),
                            SizedBox(height: 30.h),
                            BlocSelector<RegisterCubit, RegisterState, bool>(
                              selector: (state) => state is RegisterLoading,
                              bloc: registerCubit,
                              builder: (context, state) {
                                return CustomRectangleButton(
                                  title: AppStrings.signUp.toUpperCase(),
                                  titleColor: AppColors.white,
                                  isLoading: state,
                                  onPressed: () async => _onSignUpClicked(),
                                  backgroundColor: AppColors.secondary,
                                );
                              },
                            ),
                            SizedBox(height: 30.h),
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

  Future<void> _onSignUpClicked() async {
    if (nameFormKey.currentState!.validate() &&
        emailFormKey.currentState!.validate() &&
        passwordFormKey.currentState!.validate() &&
        confirmPasswordFormKey.currentState!.validate()) {
      await registerCubit.register(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
      );
    }
  }
}
