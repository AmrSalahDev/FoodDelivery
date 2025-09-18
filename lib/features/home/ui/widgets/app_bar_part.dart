import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/shared/data/models/food_model.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/features/cart/ui/cubits/cart_cubit.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppBarPart extends StatelessWidget {
  final String fullName;
  const AppBarPart({super.key, required this.fullName});

  Future<void> seedFoods() async {
    final supabase = Supabase.instance.client;

    // await supabase.from('foods').insert([
    //   {
    //     'title': 'Spaghetti Bolognese',
    //     'description': 'Classic Italian pasta with rich beef tomato sauce',
    //     'price': 85,
    //     'restaurant_name': 'Italiano',
    //     'quantity': 1,
    //     'rating': 4.5,
    //     'delivery_time': '30 min',
    //     'delivery_cost': '25 EGP',
    //     'size': '10',
    //     'category': 'pasta',
    //     'image': supabase.storage
    //         .from('food-delivery-images')
    //         .getPublicUrl('food_images/pasta/pasta_1.png'),
    //   },
    //   {
    //     'title': 'Fettuccine Alfredo',
    //     'description': 'Creamy pasta with parmesan and butter sauce',
    //     'price': 90,
    //     'restaurant_name': 'Olive Garden',
    //     'quantity': 1,
    //     'rating': 4.6,
    //     'delivery_time': '35 min',
    //     'delivery_cost': '28 EGP',
    //     'size': '10',
    //     'category': 'pasta',
    //     'image': supabase.storage
    //         .from('food-delivery-images')
    //         .getPublicUrl('food_images/pasta/pasta_2.png'),
    //   },
    //   {
    //     'title': 'Penne Arrabiata',
    //     'description': 'Spicy tomato-based pasta with garlic and chili',
    //     'price': 75,
    //     'restaurant_name': 'Pasta House',
    //     'quantity': 1,
    //     'rating': 4.2,
    //     'delivery_time': '25 min',
    //     'delivery_cost': '20 EGP',
    //     'size': '10',
    //     'category': 'pasta',
    //     'image': supabase.storage
    //         .from('food-delivery-images')
    //         .getPublicUrl('food_images/pasta/pasta_3.png'),
    //   },
    //   {
    //     'title': 'Lasagna',
    //     'description': 'Layers of pasta with beef, tomato sauce, and cheese',
    //     'price': 95,
    //     'restaurant_name': 'Mama Mia',
    //     'quantity': 1,
    //     'rating': 4.7,
    //     'delivery_time': '40 min',
    //     'delivery_cost': '30 EGP',
    //     'size': '10',
    //     'category': 'pasta',
    //     'image': supabase.storage
    //         .from('food-delivery-images')
    //         .getPublicUrl('food_images/pasta/pasta_4.png'),
    //   },
    //   {
    //     'title': 'Carbonara',
    //     'description': 'Creamy pasta with eggs, cheese, pancetta, and pepper',
    //     'price': 100,
    //     'restaurant_name': 'La Cucina',
    //     'quantity': 1,
    //     'rating': 4.8,
    //     'delivery_time': '30 min',
    //     'delivery_cost': '32 EGP',
    //     'size': '10',
    //     'category': 'pasta',
    //     'image': supabase.storage
    //         .from('food-delivery-images')
    //         .getPublicUrl('food_images/pasta/pasta_5.png'),
    //   },
    //   {
    //     'title': 'Seafood Pasta',
    //     'description':
    //         'Pasta with shrimp, calamari, and mussels in tomato sauce',
    //     'price': 120,
    //     'restaurant_name': 'Fisherman\'s Kitchen',
    //     'quantity': 1,
    //     'rating': 4.6,
    //     'delivery_time': '45 min',
    //     'delivery_cost': '35 EGP',
    //     'size': '10',
    //     'category': 'pasta',
    //     'image': supabase.storage
    //         .from('food-delivery-images')
    //         .getPublicUrl('food_images/pasta/pasta_6.png'),
    //   },
    //   {
    //     'title': 'Pesto Pasta',
    //     'description': 'Fresh basil pesto sauce with pine nuts and parmesan',
    //     'price': 85,
    //     'restaurant_name': 'Green Leaf',
    //     'quantity': 1,
    //     'rating': 4.4,
    //     'delivery_time': '25 min',
    //     'delivery_cost': '22 EGP',
    //     'size': '10',
    //     'category': 'pasta',
    //     'image': supabase.storage
    //         .from('food-delivery-images')
    //         .getPublicUrl('food_images/pasta/pasta_7.png'),
    //   },
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleButton(
          backgroundColor: Color(0xFFECF0F4),
          onPressed: () async {
            await seedFoods();
            // await Supabase.instance.client.from('restaurants').insert({
            //   'name': 'Rose Garden Restaurant',
            //   'delivery_cost': 'Free',
            //   'image_url':
            //       'https://images.pexels.com/photos/1099680/pexels-photo-1099680.jpeg',
            //   'images': [
            //     "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
            //     "https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg",
            //     "https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg",
            //     "https://images.pexels.com/photos/1099680/pexels-photo-1099680.jpeg",
            //     'https://images.pexels.com/photos/2977514/pexels-photo-2977514.jpeg',
            //     'https://images.pexels.com/photos/4252146/pexels-photo-4252146.jpeg',
            //     'https://images.pexels.com/photos/3717880/pexels-photo-3717880.jpeg',
            //   ],
            //   'found_food': ["Burger", "Chiken", "Riche", "Wings"],
            //   'rate': '4.9',
            //   'description':
            //       "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
            //   'delivery_time': '30 min',
            // });
          },
          size: 60.h,
          icon: Icon(FontAwesomeIcons.barsStaggered, color: AppColors.darkBlue),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.deliverTo.toUpperCase(),
              style: GoogleFonts.sen(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),
            SizedBox(
              width: 150.w,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.sen(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF676767),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.darkBlue,
                    size: 27.h,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        BlocSelector<CartCubit, List<FoodModel>, int>(
          selector: (state) {
            return state.length;
          },
          builder: (context, length) {
            return length == 0
                ? CustomCircleButton(
                    backgroundColor: AppColors.darkBlue,
                    onPressed: () => context.push(AppPaths.cart),
                    size: 60.h,
                    icon: Icon(
                      FontAwesomeIcons.basketShopping,
                      color: AppColors.white,
                    ),
                  )
                : Badge(
                    backgroundColor: AppColors.secondary,
                    offset: Offset(-5.w, -2.h),
                    label: Text(
                      length.toString(),
                      style: GoogleFonts.sen(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.white,
                      ),
                    ),
                    child: CustomCircleButton(
                      backgroundColor: AppColors.darkBlue,
                      size: 60.h,
                      onPressed: () => context.push(AppPaths.cart),
                      icon: Icon(
                        FontAwesomeIcons.basketShopping,
                        color: AppColors.white,
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
