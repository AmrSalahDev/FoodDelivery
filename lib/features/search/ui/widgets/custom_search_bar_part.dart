import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/utils/search_utils.dart';
import 'package:food_delivery/features/search/domain/entities/recent_keywords_entity.dart';
import 'package:food_delivery/features/search/ui/cubit/search_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBarPart extends StatefulWidget {
  final List<RecentKeywordsEntity> keywords;
  final Function(String)? onSubmitted;

  const CustomSearchBarPart({
    super.key,
    required this.keywords,
    this.onSubmitted,
  });

  @override
  State<CustomSearchBarPart> createState() => _CustomSearchBarPartState();
}

class _CustomSearchBarPartState extends State<CustomSearchBarPart> {
  late final TextEditingController controller;
  late final TextEditingController suggestionController;
  bool isSearching = false;
  String? suggestion;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    suggestionController = TextEditingController();
    controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final value = controller.text.trim();

    context.read<SearchCubit>().onSearch(value: value, controller: controller);

    if (value.isEmpty) {
      _updateState(isSearching: false, suggestion: null);
      return;
    }

    final match = SearchUtils.suggestionAlgorithm(
      value,
      widget.keywords.map((w) => w.keyword).toList(),
    );

    _updateState(isSearching: true, suggestion: match);
  }

  void _updateState({required bool isSearching, required String? suggestion}) {
    if (!mounted) return;
    setState(() {
      this.isSearching = isSearching;
      this.suggestion = suggestion;
      suggestionController.text = suggestion ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: suggestionController,
          enabled: false,
          style: GoogleFonts.sen(
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade400,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 20.w,
            ),
            filled: true,
            fillColor: AppColors.searchBarColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColors.searchBarIconColor,
              size: 24.h,
            ),
          ),
        ),

        TextField(
          autofocus: true,
          controller: controller,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            widget.onSubmitted?.call(value);
          },

          style: GoogleFonts.sen(
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 20.w,
            ),
            filled: true,
            fillColor: Colors.transparent,
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
                    onTap: () => controller.clear(),
                    child: Icon(
                      Icons.close_rounded,
                      color: AppColors.searchBarIconColor,
                      size: 24.h,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
