import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBarPart extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onSubmitted;
  final Function(String)? onSearch;
  const CustomSearchBarPart({
    super.key,
    required this.controller,
    this.onSearch,
    this.onSubmitted,
  });

  @override
  State<CustomSearchBarPart> createState() => _CustomSearchBarPartState();
}

class _CustomSearchBarPartState extends State<CustomSearchBarPart> {
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        isSearching = widget.controller.text.isNotEmpty;
        if (widget.onSearch != null) widget.onSearch!(widget.controller.text);
      });
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: widget.controller,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(value);
        }
      },

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        filled: true,
        fillColor: AppColors.searchBarColor,
        hintText: AppStrings.search,
        hintStyle: GoogleFonts.sen(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.searchBarHintColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: AppColors.searchBarIconColor,
          size: 24.h,
        ),
        suffixIcon: isSearching
            ? GestureDetector(
                onTap: () => widget.controller.clear(),
                child: Icon(
                  Icons.close_rounded,
                  color: AppColors.searchBarIconColor,
                  size: 24.h,
                ),
              )
            : null,
      ),
    );
  }
}
