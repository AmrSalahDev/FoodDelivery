import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/features/restaurant_details/domain/entities/restaurant_entity.dart';
import 'package:food_delivery/features/restaurant_details/ui/cubit/restaurant_cubit.dart';
import 'package:food_delivery/shared/widgets/shimmer_box.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestedRestaurantsPart extends StatefulWidget {
  final Function(RestaurantEntity restaurant) onTap;
  const SuggestedRestaurantsPart({super.key, required this.onTap});

  @override
  State<SuggestedRestaurantsPart> createState() =>
      _SuggestedRestaurantsPartState();
}

class _SuggestedRestaurantsPartState extends State<SuggestedRestaurantsPart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.suggestedRestaurants,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 20.h),
        BlocBuilder<RestaurantCubit, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantLoading) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                separatorBuilder: (context, index) =>
                    Divider(color: Color(0xFFEBEBEB)),
                itemBuilder: (context, index) {
                  return SuggestedRestaurantItem(isLoading: true);
                },
              );
            }
            if (state is RestaurantListLoaded) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.restaurants.length,
                separatorBuilder: (context, index) =>
                    Divider(color: Color(0xFFEBEBEB)),
                itemBuilder: (context, index) {
                  final restaurant = state.restaurants[index];
                  return SuggestedRestaurantItem(
                    restaurant: restaurant,
                    onTap: widget.onTap,
                    isLoading: false,
                  );
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class SuggestedRestaurantItem extends StatelessWidget {
  final RestaurantEntity? restaurant;
  final bool isLoading;
  final Function(RestaurantEntity restaurant)? onTap;

  const SuggestedRestaurantItem({
    super.key,
    this.restaurant,
    required this.isLoading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: restaurant != null && !isLoading
          ? () => onTap?.call(restaurant!)
          : null,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: restaurant != null && !isLoading
                ? CachedNetworkImage(
                    imageUrl: restaurant!.imageUrl,
                    height: 60.h,
                    width: 70.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Stack(
                      alignment: Alignment.center,
                      children: [ShimmerBox(height: 60.h, width: 70.w)],
                    ),
                    errorWidget: (context, url, error) =>
                        Center(child: Assets.lottie.error.lottie()),
                  )
                : ShimmerBox(height: 60.h, width: 70.w),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              restaurant != null && !isLoading
                  ? Text(
                      restaurant!.name,
                      style: GoogleFonts.sen(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.darkBlue,
                      ),
                    )
                  : ShimmerBox(height: 15.h, width: 200.w),
              SizedBox(height: 5.h),
              restaurant != null && !isLoading
                  ? Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.star,
                          color: AppColors.secondary,
                          size: 16.h,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          restaurant!.rate,
                          style: GoogleFonts.sen(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ],
                    )
                  : ShimmerBox(height: 15.h, width: 60.w),
            ],
          ),
        ],
      ),
    );
  }
}
