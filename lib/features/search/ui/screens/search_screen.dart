import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/features/restaurant_details/ui/cubit/restaurant_cubit.dart';
import 'package:food_delivery/features/search/ui/cubit/recent_keywords_cubit.dart';
import 'package:food_delivery/features/search/ui/widgets/custom_search_bar_part.dart';
import 'package:food_delivery/features/search/ui/widgets/recent_keywords_part.dart';
import 'package:food_delivery/features/search/ui/widgets/search_app_bar_part.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/food_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/restaurant_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/search_result_screen_args.dart';
import 'package:food_delivery/features/search/ui/widgets/search_popular_fast_food_part.dart';
import 'package:food_delivery/features/search/ui/widgets/suggested_restaurants_part.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController searchController;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    context.read<RestaurantCubit>().fetchRestaurants();
    context.read<RecentKeywordsCubit>().fetchKeywords();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                HeaderSection(
                  searchController: searchController,
                  onSearch: (value) =>
                      setState(() => isSearching = value.length >= 2),
                ),
                BodySection(
                  isSearching: isSearching,
                  searchController: searchController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String value) onSearch;

  const HeaderSection({
    super.key,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchAppBarPart(),
        SizedBox(height: 30.h),
        CustomSearchBarPart(
          controller: searchController,
          onSubmitted: (value) async {
            if (context.mounted) {
              context.push(
                AppPaths.searchResult,
                extra: SearchResultScreenArgs(query: value),
              );
            }

            await context.read<RecentKeywordsCubit>().saveKeyword(value);
          },
          onSearch: (value) {
            onSearch(value);
          },
        ),
        SizedBox(height: 30.h),
        RecentKeywordsPart(searchController: searchController),
      ],
    );
  }
}

class BodySection extends StatelessWidget {
  final bool isSearching;
  final TextEditingController searchController;
  const BodySection({
    super.key,
    required this.isSearching,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isSearching) ...[
          SizedBox(height: 30.h),
          SuggestedRestaurantsPart(
            onTap: (restaurant) {
              context.push(
                AppPaths.restaurantDetails,
                extra: RestaurantDetailsScreenArgs(restaurant),
              );
            },
          ),
          SizedBox(height: 30.h),
          SearchPopularFastFoodPart(
            searchController: searchController,
            onTap: (food) {
              context.push(
                AppPaths.foodDetails,
                extra: FoodDetailsScreenArgs(foodModel: food),
              );
            },
          ),
          SizedBox(height: 50.h),
        ],
      ],
    );
  }
}
