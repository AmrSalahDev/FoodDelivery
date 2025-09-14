import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/features/restaurant_details/ui/cubit/restaurant_cubit.dart';
import 'package:food_delivery/features/search/ui/widgets/custom_search_bar_part.dart';
import 'package:food_delivery/features/search/ui/widgets/recent_keywords_part.dart';
import 'package:food_delivery/features/search/ui/widgets/search_app_bar_part.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/food_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/restaurant_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/search_result_screen_args.dart';
import 'package:food_delivery/core/models/food_model.dart';
import 'package:food_delivery/features/search/ui/widgets/suggested_restaurants_part.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController searchController;
  final List<String> keywords = ['Pizza', 'Burger', 'Sandwich', 'Pasta'];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    context.read<RestaurantCubit>().fetchRestaurants();
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
                  keywords: keywords,
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

class PopularFastFoodPart extends StatefulWidget {
  final Function(FoodModel food) onTap;
  final TextEditingController searchController;
  const PopularFastFoodPart({
    super.key,
    required this.onTap,
    required this.searchController,
  });

  @override
  State<PopularFastFoodPart> createState() => _PopularFastFoodPartState();
}

class _PopularFastFoodPartState extends State<PopularFastFoodPart> {
  late List<FoodModel> foodList;
  @override
  Widget build(BuildContext context) {
    final search = widget.searchController.text.toLowerCase();

    final Map<String, List<FoodModel>> foodMap = {
      'pizza': FoodModel.pizzaList,
      'burger': FoodModel.burgerList,
      'pasta': FoodModel.pastaList,
      'sandwich': FoodModel.sandwichList,
    };

    foodList = foodMap[search] ?? FoodModel.foodList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.popularFastFood,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 45.h),

        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.w,
            mainAxisSpacing: 40.h,
            mainAxisExtent: 150.h,
          ),
          clipBehavior: Clip.none,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: foodList.length,
          itemBuilder: (context, index) {
            final foodItem = foodList[index];
            return _buildPopularFastFoodItem(foodItem: foodItem);
          },
        ),
      ],
    );
  }

  Widget _buildPopularFastFoodItem({required FoodModel foodItem}) {
    return GestureDetector(
      onTap: () => widget.onTap(foodItem),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.5), // 50%
                  Text(
                    foodItem.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sen(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  Text(
                    foodItem.restaurantName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sen(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF646982),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: -35.h,
              child: Image.asset(
                foodItem.image,
                width: constraints.maxWidth * 0.7,
                height: constraints.maxHeight * 0.7,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final TextEditingController searchController;
  final List<String> keywords;
  final Function(String value) onSearch;

  const HeaderSection({
    super.key,
    required this.searchController,
    required this.keywords,
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
          onSubmitted: (value) {
            if (!keywords.contains(value)) {
              keywords.add(value);
            }
            context.push(
              AppPaths.searchResult,
              extra: SearchResultScreenArgs(query: value),
            );
          },
          onSearch: (value) {
            onSearch(value);
          },
        ),
        SizedBox(height: 30.h),
        RecentKeywordsPart(
          keywords: keywords,
          searchController: searchController,
        ),
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
          PopularFastFoodPart(
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
