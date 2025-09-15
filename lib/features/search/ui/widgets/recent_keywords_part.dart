import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/features/search/domain/entities/recent_keywords_entity.dart';
import 'package:food_delivery/features/search/ui/cubit/recent_keywords_cubit.dart';
import 'package:food_delivery/features/search/ui/cubit/search_cubit.dart';
import 'package:food_delivery/shared/widgets/shimmer_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class RecentKeywordsPart extends StatefulWidget {
  const RecentKeywordsPart({super.key});

  @override
  State<RecentKeywordsPart> createState() => _RecentKeywordsPartState();
}

class _RecentKeywordsPartState extends State<RecentKeywordsPart> {
  @override
  void initState() {
    super.initState();
    context.read<RecentKeywordsCubit>().fetchKeywords();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SearchCubit, SearchState, String>(
      selector: (state) => state is OnSearchState ? state.value : '',
      builder: (context, value) {
        context.read<RecentKeywordsCubit>().filterKeywords(value);

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
            SizedBox(height: 20.h),
            BlocBuilder<RecentKeywordsCubit, RecentKeywordsState>(
              builder: (context, state) {
                if (state is RecentKeywordsLoading) {
                  return SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return _ChipKeyword(isLoading: true);
                      },
                    ),
                  );
                }

                if (state is RecentKeywordsLoaded) {
                  if (state.keywords.isEmpty) {
                    return Center(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade600,
                        highlightColor: Colors.grey.shade100,
                        child: Text(
                          AppStrings.noRecentKeywords,
                          style: GoogleFonts.sen(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF32343E),
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      itemCount: state.keywords.length,
                      itemBuilder: (context, index) {
                        final keyword = state.keywords[index];
                        return _ChipKeyword(keyword: keyword, isLoading: false);
                      },
                    ),
                  );
                }

                return SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }
}

class _ChipKeyword extends StatelessWidget {
  final RecentKeywordsEntity? keyword;
  final bool isLoading;

  const _ChipKeyword({this.keyword, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: keyword != null && !isLoading
          ? () {
              context.read<SearchCubit>().setText(keyword!.keyword);
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: keyword != null && !isLoading
            ? Chip(
                label: Text(
                  keyword!.keyword,
                  style: GoogleFonts.sen(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.darkBlue,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                //onDeleted: () => setState(() => widget.keywords.remove(keyword)),
                deleteIcon: Icon(
                  Icons.clear_rounded,
                  color: AppColors.darkBlue,
                ),
                shape: StadiumBorder(
                  side: BorderSide(color: Color(0xFFEDEDED), width: 1.w),
                ),
                backgroundColor: AppColors.white,
              )
            : ShimmerBox(
                height: 20.h,
                width: 100.w,
                borderRadius: BorderRadius.circular(30.r),
              ),
      ),
    );
  }
}
