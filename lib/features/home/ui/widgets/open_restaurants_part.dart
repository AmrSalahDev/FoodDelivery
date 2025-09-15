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

class OpenRestaurantsPart extends StatefulWidget {
  final Function(RestaurantEntity restaurant) onTap;
  const OpenRestaurantsPart({super.key, required this.onTap});

  @override
  State<OpenRestaurantsPart> createState() => _OpenRestaurantsPartState();
}

class _OpenRestaurantsPartState extends State<OpenRestaurantsPart> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantCubit, RestaurantState>(
      builder: (context, state) {
        if (state is RestaurantLoading) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return const RestaurantItem(isLoading: true);
            },
          );
        }

        if (state is RestaurantListLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = state.restaurants[index];
              return RestaurantItem(
                restaurant: restaurant,
                onTap: widget.onTap,
                isLoading: false,
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class RestaurantItem extends StatelessWidget {
  final Function(RestaurantEntity restaurant)? onTap;
  final RestaurantEntity? restaurant;
  final bool isLoading;

  const RestaurantItem({
    super.key,
    this.restaurant,
    this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: restaurant != null ? () => onTap?.call(restaurant!) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RestaurantImage(restaurant: restaurant, isLoading: isLoading),
          RestaurantInfo(restaurant: restaurant, isLoading: isLoading),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}

class RestaurantImage extends StatelessWidget {
  final RestaurantEntity? restaurant;
  final bool isLoading;

  const RestaurantImage({
    super.key,
    required this.restaurant,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final errorLottie = Assets.lottie.error.lottie();

    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: restaurant != null && !isLoading
          ? CachedNetworkImage(
              imageUrl: restaurant!.imageUrl,
              fit: BoxFit.cover,
              height: 200.h,
              width: double.infinity,
              placeholder: (context, url) =>
                  ShimmerBox(height: 200.h, width: double.infinity),
              errorWidget: (context, url, error) => Center(child: errorLottie),
            )
          : ShimmerBox(height: 200.h, width: double.infinity),
    );
  }
}

class RestaurantInfo extends StatelessWidget {
  final RestaurantEntity? restaurant;
  final bool isLoading;

  const RestaurantInfo({
    super.key,
    required this.restaurant,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),

        restaurant != null && !isLoading
            ? Text(
                restaurant!.name,
                style: GoogleFonts.sen(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.darkBlue,
                ),
              )
            : ShimmerBox(height: 20.h, width: 200.w),

        SizedBox(height: 12.h),

        if (restaurant?.foundFood != null &&
            restaurant!.foundFood.isNotEmpty &&
            !isLoading) ...[
          Row(
            children: List.generate(restaurant!.foundFood.length, (index) {
              final foodType = restaurant!.foundFood[index];
              final isLast = index == restaurant!.foundFood.length - 1;
              return Text(
                isLast ? foodType : "$foodType - ",
                style: GoogleFonts.sen(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFFA0A5BA),
                ),
              );
            }),
          ),
        ] else if (isLoading) ...[
          Row(
            children: List.generate(
              4,
              (index) => Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: ShimmerBox(height: 16.h, width: 40.w),
              ),
            ),
          ),
        ],

        SizedBox(height: 20.h),

        // Info Row
        Row(
          children: [
            restaurant != null && !isLoading
                ? InfoRowItem(
                    icon: FontAwesomeIcons.star,
                    text: restaurant!.rate,
                  )
                : ShimmerBox(height: 16.h, width: 60.w),

            SizedBox(width: 30.w),

            restaurant != null && !isLoading
                ? InfoRowItem(
                    icon: FontAwesomeIcons.truck,
                    text: restaurant!.deliveryCost,
                  )
                : ShimmerBox(height: 16.h, width: 60.w),

            SizedBox(width: 30.w),

            restaurant != null && !isLoading
                ? InfoRowItem(
                    icon: FontAwesomeIcons.clock,
                    text: restaurant!.deliveryTime,
                  )
                : ShimmerBox(height: 16.h, width: 60.w),
          ],
        ),
      ],
    );
  }
}

class InfoRowItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRowItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondary, size: 20.h),
        SizedBox(width: 10.w),
        Text(
          text,
          style: GoogleFonts.sen(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
          ),
        ),
      ],
    );
  }
}
