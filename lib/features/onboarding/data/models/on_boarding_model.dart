import 'package:food_delivery/core/constants/app_images.dart';
import 'package:food_delivery/core/constants/app_strings.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String description;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });

  static final List<OnBoardingModel> onBoardingItems = [
    OnBoardingModel(
      image: AppImages.onBoarding1,
      title: AppStrings.onBoardingTitle1,
      description: AppStrings.onBoardingDescription,
    ),
    OnBoardingModel(
      image: AppImages.onBoarding2,
      title: AppStrings.onBoardingTitle2,
      description: AppStrings.onBoardingDescription,
    ),
    OnBoardingModel(
      image: AppImages.onBoarding3,
      title: AppStrings.onBoardingTitle3,
      description: AppStrings.onBoardingDescription,
    ),
    OnBoardingModel(
      image: AppImages.onBoarding4,
      title: AppStrings.onBoardingTitle4,
      description: AppStrings.onBoardingDescription,
    ),
  ];
}
