import 'package:animated_digit/animated_digit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/features/home/domain/entities/category_entity.dart';
import 'package:food_delivery/features/home/ui/cubit/home_category_cubit.dart';
import 'package:food_delivery/shared/widgets/shimmer_box.dart';
import 'package:google_fonts/google_fonts.dart';

class AllCategoriesPart extends StatelessWidget {
  final Function(CategoryEntity category) onTap;
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
                return _CategoryItem(isLoading: true);
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
                return _CategoryItem(
                  onTap: onTap,
                  category: category,
                  isLoading: false,
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Function(CategoryEntity category)? onTap;
  final CategoryEntity? category;
  final bool isLoading;

  const _CategoryItem({this.onTap, this.category, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: category != null ? () => onTap?.call(category!) : null,
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
                    _CategoryImage(
                      category: category,
                      isLoading: isLoading,
                      constraints: constraints,
                    ),
                    const Spacer(),
                    _CategoryInfo(category: category, isLoading: isLoading),
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

class _CategoryImage extends StatelessWidget {
  final CategoryEntity? category;
  final bool isLoading;
  final BoxConstraints constraints;

  const _CategoryImage({
    this.category,
    required this.isLoading,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final loadingLottie = Assets.lottie.handLoading.lottie(
      width: constraints.maxWidth * 0.60,
      height: constraints.maxHeight * 0.55,
      fit: BoxFit.contain,
    );

    final errorLottie = Assets.lottie.error.lottie(
      width: constraints.maxWidth * 0.60,
      height: constraints.maxHeight * 0.55,
      fit: BoxFit.contain,
    );

    Widget showLoading() {
      return Transform.scale(scale: 1.7, child: loadingLottie);
    }

    Widget showError() {
      return Transform.scale(scale: 1.4, child: errorLottie);
    }

    return category != null && !isLoading
        ? CachedNetworkImage(
            height: constraints.maxHeight * 0.55,
            width: constraints.maxWidth * 0.60,
            imageUrl: category!.image,
            fit: BoxFit.contain,
            placeholder: (context, url) => showLoading(),
            errorWidget: (context, url, error) {
              return showError();
            },
          )
        : showLoading();
  }
}

class _CategoryInfo extends StatelessWidget {
  final CategoryEntity? category;
  final bool isLoading;
  const _CategoryInfo({this.category, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        category != null && !isLoading
            ? Text(
                category!.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.sen(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                ),
              )
            : Column(
                children: [
                  ShimmerBox(height: 15.h, width: 100.w),
                  SizedBox(height: 10.h),
                ],
              ),
        Row(
          children: [
            !isLoading
                ? Text(
                    AppStrings.starting,
                    style: GoogleFonts.sen(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF646982),
                    ),
                  )
                : ShimmerBox(height: 15.h, width: 60.w),
            const Spacer(),
            category != null && !isLoading
                ? AnimatedDigitWidget(
                    value: category!.startingPrice,
                    prefix: '\$',
                    textStyle: GoogleFonts.sen(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF32343E),
                    ),
                  )
                : ShimmerBox(height: 15.h, width: 40.w),
          ],
        ),
      ],
    );
  }
}
