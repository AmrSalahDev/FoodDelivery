import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/shared/widgets/custom_back_button.dart';
import 'package:food_delivery/shared/widgets/custom_rectangle_button.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';
import 'package:otp_resend_timer/otp_resend_timer.dart';
import 'package:pinput/pinput.dart';

class VerificationPasswordScreen extends StatefulWidget {
  final String email;
  const VerificationPasswordScreen({super.key, required this.email});

  @override
  State<VerificationPasswordScreen> createState() =>
      _VerificationPasswordScreenState();
}

class _VerificationPasswordScreenState
    extends State<VerificationPasswordScreen> {
  late final OtpResendTimerController otpResendTimerController;
  bool isOtpSent = false;

  @override
  void initState() {
    super.initState();
    otpResendTimerController = OtpResendTimerController(initialTime: 60);
  }

  @override
  void dispose() {
    otpResendTimerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 62.w,
      height: 62.h,
      textStyle: TextStyle(
        fontSize: 16.sp,
        color: Color(0xFF32343E),
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFF0F5FA),
      ),
    );

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
                      "Verification",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sen(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "We have sent a code to your email",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sen(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      widget.email,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sen(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Code",
                                style: GoogleFonts.sen(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF32343E),
                                ),
                              ),
                              const Spacer(),

                              OtpResendTimer(
                                controller: otpResendTimerController,
                                autoStart: true,
                                timerMessageStyle: TextStyle(
                                  color: Color(0xFF32343E),
                                ),
                                resendMessage: isOtpSent ? "" : "Resend",
                                resendMessageStyle: GoogleFonts.sen(
                                  color: Color(0xFF32343E),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                timerMessage: "Resend in ",
                                readyMessage: "",
                                onFinish: () {
                                  setState(() {
                                    isOtpSent = false;
                                  });
                                },
                                onResendClicked: () {},
                                onStart: () {
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) {
                                    setState(() {
                                      isOtpSent = true;
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),

                          Pinput(defaultPinTheme: defaultPinTheme),

                          SizedBox(height: 30.h),

                          CustomRectangleButton(
                            title: "Verify",
                            titleColor: AppColors.white,
                            onPressed: () {},
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
