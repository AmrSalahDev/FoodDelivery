import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarPart extends StatelessWidget {
  const SearchBarPart({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppPaths.search),
      child: Container(
        height: 65.h,
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: Color(0xFFA0A5BA), size: 27.h),
            SizedBox(width: 10.w),
            Text(
              "Search dishes, restaurants",
              style: GoogleFonts.sen(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                color: Color(0xFF676767),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
