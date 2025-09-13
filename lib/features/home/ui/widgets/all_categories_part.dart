import 'package:animated_digit/animated_digit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/features/home/data/models/category_model.dart';
import 'package:food_delivery/features/home/ui/cubit/home_category_cubit.dart';
import 'package:food_delivery/shared/widgets/custom_skeletonizer.dart';
import 'package:google_fonts/google_fonts.dart';

class AllCategoriesPart extends StatelessWidget {
  final Function(CategoryModel category) onTap;
  const AllCategoriesPart({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.h,
      child: BlocBuilder<HomeCategoryCubit, HomeCategoryState>(
        builder: (context, state) {
          if (state is HomeCategoryLoading) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              clipBehavior: Clip.none,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _buildCategoryItem(isLoading: true, category: null);
              },
            );
          }
          if (state is HomeCategoryLoaded) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              clipBehavior: Clip.none,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return _buildCategoryItem(category: category, isLoading: false);
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCategoryItem({
    CategoryModel? category,
    required bool isLoading,
  }) {
    return GestureDetector(
      onTap: isLoading && category == null ? null : () => onTap(category!),
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: SizedBox(
          width: 160.w,
          height: 170.h,
          child: LayoutBuilder(
            builder: (context, constraints) => Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ImagesPart(
                      category: category,
                      isLoading: isLoading,
                      constraints: constraints,
                    ),
                    const Spacer(),
                    _TextPart(category: category, isLoading: isLoading),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ImagesPart extends StatelessWidget {
  final CategoryModel? category;
  final bool isLoading;
  final BoxConstraints constraints;

  const _ImagesPart({
    this.category,
    required this.isLoading,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Transform.scale(
            scale: 1.6,
            child: Assets.lottie.handLoading.lottie(
              width: constraints.maxWidth * 0.60,
              height: constraints.maxHeight * 0.55,
              fit: BoxFit.contain,
            ),
          )
        : CachedNetworkImage(
            height: constraints.maxHeight * 0.55,
            width: constraints.maxWidth * 0.60,
            imageUrl: category?.image ?? '',
            fit: BoxFit.contain,
            placeholder: (context, url) => Transform.scale(
              scale: 1.6,
              child: Assets.lottie.handLoading.lottie(
                width: constraints.maxWidth * 0.60,
                height: constraints.maxHeight * 0.55,
                fit: BoxFit.contain,
              ),
            ),
            errorWidget: (context, url, error) {
              return isLoading
                  ? Container(
                      height: constraints.maxHeight * 0.55,
                      width: constraints.maxWidth * 0.60,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    )
                  : Transform.scale(
                      scale: 1.4,
                      child: Assets.lottie.error.lottie(
                        width: constraints.maxWidth * 0.60,
                        height: constraints.maxHeight * 0.55,
                        fit: BoxFit.contain,
                      ),
                    );
            },
          );
  }
}

class _TextPart extends StatelessWidget {
  final CategoryModel? category;
  final bool isLoading;
  const _TextPart({this.category, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return CustomSkeletonizer(
      enabled: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category?.title ?? 'unknown',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.sen(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
          ),
          Row(
            children: [
              Text(
                AppStrings.starting,
                style: GoogleFonts.sen(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF646982),
                ),
              ),
              const Spacer(),
              AnimatedDigitWidget(
                value: category?.startingPrice ?? 0.0,
                prefix: '\$',
                textStyle: GoogleFonts.sen(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF32343E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
