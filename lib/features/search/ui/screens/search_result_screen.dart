import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/features/restaurant_details/ui/cubit/restaurant_cubit.dart';
import 'package:food_delivery/features/search/ui/widgets/open_restaurants_part.dart';
import 'package:food_delivery/features/search/ui/widgets/search_result_app_bar_part.dart';
import 'package:food_delivery/features/search/ui/widgets/search_result_popular_food_part.dart';

import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/food_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/restaurant_details_screen_args.dart';
import 'package:food_delivery/shared/widgets/my_custom_refresh_indicator.dart';
import 'package:go_router/go_router.dart';

class SearchResultScreen extends StatefulWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RestaurantCubit>().fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              HeaderSection(query: widget.query),
              SizedBox(height: 30.h),
              Expanded(
                child: MyCustomRefreshIndicator(
                  onRefresh: () async =>
                      await context.read<RestaurantCubit>().fetchRestaurants(),
                  child: SingleChildScrollView(
                    child: BodySection(query: widget.query),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final String query;
  const HeaderSection({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return SearchResultAppBarPart(query: query);
  }
}

class BodySection extends StatelessWidget {
  final String query;
  const BodySection({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchResultPopularFoodPart(
          query: query,
          onTap: (food) {
            context.push(
              AppPaths.foodDetails,
              extra: FoodDetailsScreenArgs(foodModel: food),
            );
          },
        ),
        SizedBox(height: 40.h),
        OpenRestaurantsPart(
          onTap: (restaurant) {
            context.push(
              AppPaths.restaurantDetails,
              extra: RestaurantDetailsScreenArgs(restaurant),
            );
          },
        ),
      ],
    );
  }
}
