import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_delivery/core/routes/args/food_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/restaurant_details_screen_args.dart';
import 'package:food_delivery/features/restaurant_details/ui/cubit/restaurant_cubit.dart';
import 'package:food_delivery/features/search/domain/entities/recent_keywords_entity.dart';
import 'package:food_delivery/features/search/ui/cubit/recent_keywords_cubit.dart';
import 'package:food_delivery/features/search/ui/cubit/search_cubit.dart';
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                HeaderSection(),
                SizedBox(height: 20.h),
                BodySection(),
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
        SearchAppBarPart(),
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
        RecentKeywordsPart(),
      ],
    );
  }
}

class BodySection extends StatelessWidget {
  const BodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is OnSearchState && state.value.isNotEmpty) {
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
                    keyword: state.value,
                    onTap: (food) {
                      context.push(
                        AppPaths.foodDetails,
                        extra: FoodDetailsScreenArgs(foodModel: food),
                      );
                    },
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
