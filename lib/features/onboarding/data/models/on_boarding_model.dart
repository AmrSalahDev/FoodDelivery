import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';

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
      image: Assets.images.onboarding1.path,
      title: AppStrings.onBoardingTitle1,
      description: AppStrings.onBoardingDescription,
    ),
    OnBoardingModel(
      image: Assets.images.onboarding2.path,
      title: AppStrings.onBoardingTitle2,
      description: AppStrings.onBoardingDescription,
    ),
    OnBoardingModel(
      image: Assets.images.onboarding3.path,
      title: AppStrings.onBoardingTitle3,
      description: AppStrings.onBoardingDescription,
    ),
    OnBoardingModel(
      image: Assets.images.onboarding4.path,
      title: AppStrings.onBoardingTitle4,
      description: AppStrings.onBoardingDescription,
    ),
  ];
}
