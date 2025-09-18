import 'package:extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/features/search/domain/entities/recent_keywords_entity.dart';
import 'package:food_delivery/features/search/ui/cubit/drop_down_cubit.dart';
import 'package:food_delivery/features/search/ui/cubit/recent_keywords_cubit.dart';
import 'package:food_delivery/shared/cubits/food_cubit.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

class SearchResultAppBarPart extends StatelessWidget {
  final String? query;
  const SearchResultAppBarPart({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleButton(
          onPressed: () => Navigator.pop(context),
          backgroundColor: AppColors.lightGray,
          size: 55.h,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.h,
            color: AppColors.darkBlue,
          ),
        ),
        SizedBox(width: 10.w),
        _FoodDropDown(query: query),
        const Spacer(),
        CustomCircleButton(
          onPressed: () => Navigator.pop(context),
          backgroundColor: AppColors.darkBlue,
          size: 55.h,
          icon: Icon(Icons.search_rounded, size: 20.h, color: AppColors.white),
        ),
        SizedBox(width: 10.w),
        CustomCircleButton(
          onPressed: () {},
          backgroundColor: AppColors.lightGray,
          size: 55.h,
          icon: Assets.icons.icSortSettings.image(height: 20.h, width: 20.h),
        ),
      ],
    );
  }
}

class _FoodDropDown extends StatefulWidget {
  final String? query;
  const _FoodDropDown({required this.query});

  @override
  State<_FoodDropDown> createState() => _FoodDropDownState();
}

class _FoodDropDownState extends State<_FoodDropDown> {
  @override
  void initState() {
    super.initState();
    context.read<RecentKeywordsCubit>().fetchKeywords();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.w,
      child:
          BlocSelector<
            RecentKeywordsCubit,
            RecentKeywordsState,
            List<RecentKeywordsEntity>
          >(
            selector: (state) =>
                state is RecentKeywordsLoaded ? state.keywords : [],
            builder: (context, state) {
              return GestureDetector(
                onTapDown: (details) async {
                  final selected = await showMenu<RecentKeywordsEntity>(
                    context: context,
                    constraints: BoxConstraints(
                      maxHeight: context.screenHeight * 0.3,
                      minWidth: context.screenWidth * 0.8,
                      maxWidth: context.screenWidth * 0.8,
                    ),
                    position: RelativeRect.fromLTRB(
                      20.w,
                      140.h,
                      details.globalPosition.dx,
                      0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    color: AppColors.white,
                    items: [
                      ...state.map(
                        (e) => PopupMenuItem<RecentKeywordsEntity>(
                          value: e,
                          child: Text(
                            e.keyword,
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              color: AppColors.darkBlue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );

                  if (selected != null) {
                    if (context.mounted) {
                      context.read<DropDownCubit>().select(selected.keyword);
                    }
                  }
                },
                child: BlocListener<DropDownCubit, DropDownState>(
                  listenWhen: (previous, current) => previous != current,
                  listener: (context, state) {
                    if (state is DropDownSelected) {
                      context.read<FoodCubit>().fetchFoods(
                        category: state.value,
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: Color(0xFFECF0F4), width: 1),
                      color: AppColors.white,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        SizedBox(width: 15.w),
                        Expanded(
                          child:
                              BlocSelector<
                                DropDownCubit,
                                DropDownState,
                                String
                              >(
                                selector: (state) {
                                  return state is DropDownSelected
                                      ? state.value
                                      : widget.query ?? '';
                                },
                                builder: (context, state) {
                                  return Text(
                                    state.capitalizeFirstLetter(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.sen(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.darkBlue,
                                    ),
                                  );
                                },
                              ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 24.h,
                          color: AppColors.secondary,
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
