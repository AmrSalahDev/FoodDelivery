import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/models/restaurant_imodel.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/food_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/restaurant_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/search_result_screen_args.dart';
import 'package:food_delivery/core/models/food_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

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

class SuggestedRestaurantPart extends StatefulWidget {
  final Function(RestaurantModel restaurant) onTap;
  const SuggestedRestaurantPart({super.key, required this.onTap});

  @override
  State<SuggestedRestaurantPart> createState() =>
      _SuggestedRestaurantPartState();
}

class _SuggestedRestaurantPartState extends State<SuggestedRestaurantPart> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.suggestedRestaurants,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 20.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: RestaurantModel.restaurantItems.length,
          separatorBuilder: (context, index) =>
              Divider(color: Color(0xFFEBEBEB)),
          itemBuilder: (context, index) {
            final restaurant = RestaurantModel.restaurantItems[index];
            return _buildSuggestedRestaurantItem(restaurant);
          },
        ),
      ],
    );
  }

  Widget _buildSuggestedRestaurantItem(RestaurantModel restaurant) {
    return GestureDetector(
      onTap: () => widget.onTap(restaurant),
      child: Skeletonizer(
        enabled: _isLoading,
        effect: ShimmerEffect(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade100,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: restaurant.image,
                height: 60.h,
                width: 70.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Skeletonizer(
                      enabled: true,
                      effect: ShimmerEffect(
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.grey.shade100,
                      ),
                      child: Container(
                        height: 60.h,
                        width: 70.w,
                        color: Colors.grey.shade200,
                      ),
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
                    height: 60.h,
                    width: 70.w,
                    fit: BoxFit.cover,
                  );
                },
                errorWidget: (context, url, error) =>
                    Center(child: Assets.lottie.error.lottie()),
              ),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () => widget.onTap(restaurant),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: GoogleFonts.sen(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.star,
                        color: AppColors.secondary,
                        size: 16.h,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        restaurant.rate,
                        style: GoogleFonts.sen(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: AppColors.darkBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onSubmitted;
  final Function(String)? onSearch;
  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onSearch,
    this.onSubmitted,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        isSearching = widget.controller.text.isNotEmpty;
        if (widget.onSearch != null) widget.onSearch!(widget.controller.text);
      });
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: widget.controller,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(value);
        }
      },

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        filled: true,
        fillColor: AppColors.searchBarColor,
        hintText: AppStrings.search,
        hintStyle: GoogleFonts.sen(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.searchBarHintColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: AppColors.searchBarIconColor,
          size: 24.h,
        ),
        suffixIcon: isSearching
            ? GestureDetector(
                onTap: () => widget.controller.clear(),
                child: Icon(
                  Icons.close_rounded,
                  color: AppColors.searchBarIconColor,
                  size: 24.h,
                ),
              )
            : null,
      ),
    );
  }
}

class AppBarPart extends StatelessWidget {
  const AppBarPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleButton(
          onPressed: () {},
          backgroundColor: AppColors.lightGray,
          size: 55.h,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkBlue,
            size: 20.h,
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          AppStrings.search,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.darkBlue,
          ),
        ),
        const Spacer(),
        Badge(
          backgroundColor: AppColors.secondary,
          offset: Offset(-5.w, 0),
          label: Text(
            faker.faker.randomGenerator.integer(100).toString(),
            style: GoogleFonts.sen(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.white,
            ),
          ),
          child: CustomCircleButton(
            onPressed: () {},
            backgroundColor: AppColors.darkBlue,
            size: 55.h,
            icon: Icon(
              FontAwesomeIcons.basketShopping,
              size: 24.h,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class RecentKeywordsPart extends StatefulWidget {
  final List<String> keywords;
  final TextEditingController searchController;
  const RecentKeywordsPart({
    super.key,
    required this.keywords,
    required this.searchController,
  });

  @override
  State<RecentKeywordsPart> createState() => _RecentKeywordsPartState();
}

class _RecentKeywordsPartState extends State<RecentKeywordsPart> {
  @override
  Widget build(BuildContext context) {
    debugPrint("RecentKeywordsPart");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.recentKeywords,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 10.w,
            children: widget.keywords
                .map(
                  (keyword) => GestureDetector(
                    onTap: () =>
                        setState(() => widget.searchController.text = keyword),
                    child: Chip(
                      label: Text(
                        keyword,
                        style: GoogleFonts.sen(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      onDeleted: () =>
                          setState(() => widget.keywords.remove(keyword)),
                      deleteIcon: Icon(
                        Icons.clear_rounded,
                        color: AppColors.darkBlue,
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(color: Color(0xFFEDEDED), width: 1.w),
                      ),
                      backgroundColor: AppColors.white,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
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
    debugPrint("HeaderSection");
    return Column(
      children: [
        AppBarPart(),
        SizedBox(height: 30.h),
        CustomSearchBar(
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
    debugPrint("BodySection");
    return Column(
      children: [
        if (isSearching) ...[
          SizedBox(height: 30.h),
          SuggestedRestaurantPart(
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

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("FooterSection");
    return const SizedBox.shrink();
  }
}
