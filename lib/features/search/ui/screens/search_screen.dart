import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_delivery/core/routes/args/food_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/restaurant_details_screen_args.dart';
import 'package:food_delivery/shared/cubits/restaurant_cubit.dart';
import 'package:food_delivery/features/search/domain/entities/recent_keywords_entity.dart';
import 'package:food_delivery/features/search/ui/cubit/recent_keywords_cubit.dart';
import 'package:food_delivery/features/search/ui/widgets/custom_search_bar_part.dart';
import 'package:food_delivery/features/search/ui/widgets/recent_keywords_part.dart';
import 'package:food_delivery/features/search/ui/widgets/search_app_bar_part.dart';
import 'package:food_delivery/core/routes/app_router.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<RecentKeywordsCubit>().fetchKeywords();
    context.read<RestaurantCubit>().fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderSection(),
                SizedBox(height: 20.h),
                const BodySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchAppBarPart(),
        SizedBox(height: 30.h),

        BlocSelector<
          RecentKeywordsCubit,
          RecentKeywordsState,
          List<RecentKeywordsEntity>
        >(
          selector: (state) =>
              state is RecentKeywordsLoaded ? state.keywords : [],
          builder: (context, keywords) {
            return CustomSearchBarPart(
              keywords: keywords,
              onSubmitted: (value) async {
                if (context.mounted) {
                  context.push(
                    AppPaths.searchResult,
                    extra: SearchResultScreenArgs(query: value),
                  );
                }
                await context.read<RecentKeywordsCubit>().saveKeyword(value);
              },
            );
          },
        ),
        SizedBox(height: 20.h),
        const RecentKeywordsPart(),
      ],
    );
  }
}

class BodySection extends StatelessWidget {
  const BodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
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
              onTap: (food) {
                context.push(
                  AppPaths.foodDetails,
                  extra: FoodDetailsScreenArgs(foodEntity: food),
                );
              },
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
