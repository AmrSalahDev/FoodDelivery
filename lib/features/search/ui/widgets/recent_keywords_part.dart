import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentKeywordsPart extends StatefulWidget {
  final List<String> keywords;
  final TextEditingController searchController;
  const RecentKeywordsPart({
    super.key,
    required this.keywords,
    required this.searchController,
  });

  @override
  State<RecentKeywordsPart> createState() => _RecentKeywordsPartState();
}

class _RecentKeywordsPartState extends State<RecentKeywordsPart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.recentKeywords,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 10.w,
            children: widget.keywords
                .map(
                  (keyword) => GestureDetector(
                    onTap: () =>
                        setState(() => widget.searchController.text = keyword),
                    child: Chip(
                      label: Text(
                        keyword,
                        style: GoogleFonts.sen(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      onDeleted: () =>
                          setState(() => widget.keywords.remove(keyword)),
                      deleteIcon: Icon(
                        Icons.clear_rounded,
                        color: AppColors.darkBlue,
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(color: Color(0xFFEDEDED), width: 1.w),
                      ),
                      backgroundColor: AppColors.white,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
