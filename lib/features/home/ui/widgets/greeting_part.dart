import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/features/home/ui/cubit/home_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class GreetingPart extends StatelessWidget {
  final String fisrtName;
  const GreetingPart({super.key, required this.fisrtName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Text.rich(
          TextSpan(
            text: "Hey $fisrtName, ",
            style: GoogleFonts.sen(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: Color(0xFF1E1D1D),
            ),
            children: [
              TextSpan(
                text: state is UserGreeting ? state.greeting : "",
                style: GoogleFonts.sen(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1D1D),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
