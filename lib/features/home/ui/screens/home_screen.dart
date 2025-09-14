import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/routes/args/restaurant_details_screen_args.dart';
import 'package:food_delivery/features/home/ui/cubit/home_category_cubit.dart';
import 'package:food_delivery/features/home/ui/widgets/all_categories_part.dart';
import 'package:food_delivery/features/home/ui/widgets/app_bar_part.dart';
import 'package:food_delivery/features/home/ui/widgets/greeting_part.dart';
import 'package:food_delivery/features/home/ui/widgets/open_restaurants_part.dart';
import 'package:food_delivery/features/home/ui/widgets/search_bar_part.dart';
import 'package:food_delivery/features/home/ui/widgets/see_all_bar_part.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/search_result_screen_args.dart';
import 'package:food_delivery/features/home/ui/cubit/home_cubit.dart';
import 'package:food_delivery/features/home/ui/widgets/show_offer_dialog.dart';
import 'package:food_delivery/features/restaurant_details/ui/cubit/restaurant_cubit.dart';
import 'package:food_delivery/shared/widgets/my_custom_refresh_indicator.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  final String userLocation;
  const HomeScreen({super.key, required this.userLocation});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AfterLayoutMixin<HomeScreen> {
  late String fullName;
  late String fisrtName;

  @override
  void initState() {
    super.initState();
    fullName = faker.faker.person.name();
    fisrtName = fullName.split(" ")[0];
    context.read<HomeCubit>().startGreeting();
    context.read<HomeCategoryCubit>().fetchCategories();
    context.read<RestaurantCubit>().fetchRestaurants(limit: 2);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 260.h,
              backgroundColor: AppColors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: HeaderSecton(
                  fisrtName: fisrtName,
                  fullName: fullName,
                ),
              ),
            ),
          ],
          body: MyCustomRefreshIndicator(
            onRefresh: () async {
              if (!mounted) return;

              await Future.wait([
                context.read<HomeCategoryCubit>().fetchCategories(),
                context.read<RestaurantCubit>().fetchRestaurants(limit: 2),
              ]);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  BodySection(),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(hours: 1), () {
      if (context.mounted) {
        ShowOfferDialog.showOfferDialog(context);
      }
    });
  }
}

class BodySection extends StatelessWidget {
  const BodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SeeAllBarPart(title: AppStrings.allCategories),
              SizedBox(height: 30.h),
              AllCategoriesPart(
                onTap: (food) {
                  context.push(
                    AppPaths.searchResult,
                    extra: SearchResultScreenArgs(query: food.title),
                  );
                },
              ),
              SizedBox(height: 50.h),
              SeeAllBarPart(title: AppStrings.openRestaurants),
              SizedBox(height: 30.h),
              OpenRestaurantsPart(
                onTap: (restaurant) {
                  context.push(
                    AppPaths.restaurantDetails,
                    extra: RestaurantDetailsScreenArgs(restaurant),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HeaderSecton extends StatelessWidget {
  final String fullName;
  final String fisrtName;

  const HeaderSecton({
    super.key,
    required this.fullName,
    required this.fisrtName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          AppBarPart(fullName: fullName),
          SizedBox(height: 30.h),
          GreetingPart(fisrtName: fisrtName),
          SizedBox(height: 30.h),
          SearchBarPart(),
        ],
      ),
    );
  }
}
