import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/shared/cubits/restaurant_cubit.dart';
import 'package:food_delivery/features/search/ui/cubit/drop_down_cubit.dart';
import 'package:food_delivery/features/search/ui/widgets/open_restaurants_part.dart';
import 'package:food_delivery/features/search/ui/widgets/search_result_app_bar_part.dart';
import 'package:food_delivery/features/search/ui/widgets/search_result_popular_food_part.dart';

import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/food_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/restaurant_details_screen_args.dart';
import 'package:food_delivery/shared/cubits/food_cubit.dart';
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
                child: BlocSelector<DropDownCubit, DropDownState, String>(
                  selector: (state) {
                    if (state is DropDownSelected) {
                      context.read<FoodCubit>().fetchFoods(
                        category: state.value,
                      );
                      context.read<RestaurantCubit>().fetchRestaurants(
                        category: state.value,
                      );
                      return state.value;
                    }
                    return widget.query;
                  },
                  builder: (context, state) {
                    return MyCustomRefreshIndicator(
                      onRefresh: () async {
                        Future.wait([
                          context.read<FoodCubit>().fetchFoods(category: state),
                          context.read<RestaurantCubit>().fetchRestaurants(
                            category: state,
                          ),
                        ]);
                      },
                      child: SingleChildScrollView(
                        clipBehavior: Clip.none,
                        child: Container(
                          color: AppColors.white,
                          child: BodySection(query: state),
                        ),
                      ),
                    );
                  },
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchResultPopularFoodPart(
          query: query,
          onTap: (food) {
            context.push(
              AppPaths.foodDetails,
              extra: FoodDetailsScreenArgs(foodEntity: food),
            );
          },
        ),
        SizedBox(height: 40.h),
        OpenRestaurantsPart(
          query: query,
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
