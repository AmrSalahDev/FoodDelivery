import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/app/widgets/custom_circle_button.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/search_result_screen_args.dart';
import 'package:food_delivery/app/models/food_model.dart';
import 'package:food_delivery/features/home/data/models/suggested_restaurants_model.dart';
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
  final List<String> keywords = [];
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
                _buildAppBar(),
                SizedBox(height: 30.h),
                CustomSearchBar(
                  controller: searchController,
                  onSubmitted: (value) {
                    setState(() {
                      keywords.add(value);
                      context.push(
                        AppPaths.homeSearchResult,
                        extra: SearchResultScreenArgs(query: value),
                      );
                    });
                  },
                  onSearch: (value) {
                    isSearching = value.isNotEmpty && value.length > 1;
                    setState(() {});
                  },
                ),
                if (isSearching) ...[
                  SizedBox(height: 30.h),
                  _buildRecentKeywords(),
                  SizedBox(height: 30.h),
                  _buildSuggestedRestaurants(),
                  SizedBox(height: 30.h),
                  _buildPopularFastFood(),
                  SizedBox(height: 50.h),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopularFastFood() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Popular Fast Food",
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 35.h),

        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 40.h,
            mainAxisExtent: 150.h,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: FoodModel.foodList.length,
          itemBuilder: (context, index) =>
              _buildPopularFastFoodItem(index: index),
        ),
      ],
    );
  }

  Widget _buildPopularFastFoodItem({required int index}) {
    return LayoutBuilder(
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
                  FoodModel.foodList[index].title,
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
                  FoodModel.foodList[index].title,
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
              FoodModel.foodList[index].image,
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.7,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedRestaurants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Suggested Restaurants",
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
          itemCount: SuggestedRestaurantsModel.suggestedRestaurants.length,
          separatorBuilder: (context, index) =>
              Divider(color: Color(0xFFEBEBEB)),
          itemBuilder: (context, index) => RestaurantItem(index: index),
        ),
      ],
    );
  }

  Widget _buildRecentKeywords() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Keywords",
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
            children: keywords
                .map(
                  (keyword) => Chip(
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
                    onDeleted: () => setState(() => keywords.remove(keyword)),
                    deleteIcon: Icon(
                      Icons.clear_rounded,
                      color: AppColors.darkBlue,
                    ),
                    shape: StadiumBorder(
                      side: BorderSide(color: Color(0xFFEDEDED), width: 1.w),
                    ),
                    backgroundColor: AppColors.white,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Row _buildAppBar() {
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

class RestaurantItem extends StatefulWidget {
  final int index;
  const RestaurantItem({super.key, required this.index});

  @override
  State<RestaurantItem> createState() => _RestaurantItemState();
}

class _RestaurantItemState extends State<RestaurantItem> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final restaurant =
        SuggestedRestaurantsModel.suggestedRestaurants[widget.index];

    return Skeletonizer(
      enabled: _isLoading,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CachedNetworkImage(
              imageUrl: restaurant.image,
              height: 60.h,
              width: 70.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 60.h,
                width: 70.w,
                color: AppColors.lightGray,
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
                  Center(child: Icon(Icons.error, color: Colors.red)),
            ),
          ),
          SizedBox(width: 10.w),
          Column(
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
        ],
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
