import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/core/models/restaurant_imodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OpenRestaurantsPart extends StatefulWidget {
  final Function(RestaurantModel) onTap;
  const OpenRestaurantsPart({super.key, required this.onTap});

  @override
  State<OpenRestaurantsPart> createState() => _OpenRestaurantsPartState();
}

class _OpenRestaurantsPartState extends State<OpenRestaurantsPart> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: RestaurantModel.restaurantItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final restaurant = RestaurantModel.restaurantItems[index];
        return _buildRestaurantItem(restaurant);
      },
    );
  }

  Widget _buildRestaurantItem(RestaurantModel restaurant) {
    return GestureDetector(
      onTap: () => widget.onTap(restaurant),
      child: Skeletonizer(
        enabled: _isLoading,
        ignorePointers: _isLoading,
        effect: ShimmerEffect(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: CachedNetworkImage(
                imageUrl: restaurant.image,
                fit: BoxFit.fill,
                height: 200.h,
                width: double.infinity,

                placeholder: (context, url) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                    ),

                    Assets.lottie.handLoading.lottie(),
                  ],
                ),
                imageBuilder: (context, imageProvider) {
                  // Use addPostFrameCallback to avoid calling setState during build
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted && _isLoading) {
                      setState(() => _isLoading = false);
                    }
                  });
                  return Image(
                    image: imageProvider,
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  );
                },
                errorWidget: (context, url, error) =>
                    Center(child: Assets.lottie.error.lottie()),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              restaurant.name,
              style: GoogleFonts.sen(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.darkBlue,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: restaurant.foodTypes
                  .map(
                    (foodType) => Text(
                      foodType == restaurant.foodTypes.last
                          ? foodType
                          : "$foodType - ",
                      style: GoogleFonts.sen(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFA0A5BA),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.star,
                  color: AppColors.secondary,
                  size: 20.h,
                ),
                SizedBox(width: 10.w),
                Text(
                  restaurant.rate,
                  style: GoogleFonts.sen(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
                SizedBox(width: 30.w),
                Icon(
                  FontAwesomeIcons.truck,
                  color: AppColors.secondary,
                  size: 20.h,
                ),
                SizedBox(width: 10.w),
                Text(
                  restaurant.deliveryCost,
                  style: GoogleFonts.sen(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
                SizedBox(width: 30.w),
                Icon(
                  FontAwesomeIcons.clock,
                  color: AppColors.secondary,
                  size: 20.h,
                ),
                SizedBox(width: 10.w),
                Text(
                  restaurant.deliveryTime,
                  style: GoogleFonts.sen(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
