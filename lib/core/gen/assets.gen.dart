// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_sort_settings.png
  AssetGenImage get icSortSettings =>
      const AssetGenImage('assets/icons/ic_sort_settings.png');

  /// List of all assets
  List<AssetGenImage> get values => [icSortSettings];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/food
  $AssetsImagesFoodGen get food => const $AssetsImagesFoodGen();

  /// File path: assets/images/location_access.png
  AssetGenImage get locationAccess =>
      const AssetGenImage('assets/images/location_access.png');

  /// File path: assets/images/onboarding_1.png
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/onboarding_1.png');

  /// File path: assets/images/onboarding_2.png
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/images/onboarding_2.png');

  /// File path: assets/images/onboarding_3.png
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/onboarding_3.png');

  /// File path: assets/images/onboarding_4.png
  AssetGenImage get onboarding4 =>
      const AssetGenImage('assets/images/onboarding_4.png');

  /// Directory path: assets/images/restaurants
  $AssetsImagesRestaurantsGen get restaurants =>
      const $AssetsImagesRestaurantsGen();

  /// List of all assets
  List<AssetGenImage> get values => [
    locationAccess,
    onboarding1,
    onboarding2,
    onboarding3,
    onboarding4,
  ];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/logo/splash.png');

  /// List of all assets
  List<AssetGenImage> get values => [splash];
}

class $AssetsImagesFoodGen {
  const $AssetsImagesFoodGen();

  /// File path: assets/images/food/buffalo_burger.png
  AssetGenImage get buffaloBurger =>
      const AssetGenImage('assets/images/food/buffalo_burger.png');

  /// File path: assets/images/food/buffalo_pizza.png
  AssetGenImage get buffaloPizza =>
      const AssetGenImage('assets/images/food/buffalo_pizza.png');

  /// File path: assets/images/food/bullseye_burger.png
  AssetGenImage get bullseyeBurger =>
      const AssetGenImage('assets/images/food/bullseye_burger.png');

  /// File path: assets/images/food/burger.png
  AssetGenImage get burger =>
      const AssetGenImage('assets/images/food/burger.png');

  /// File path: assets/images/food/burger_bistro.png
  AssetGenImage get burgerBistro =>
      const AssetGenImage('assets/images/food/burger_bistro.png');

  /// File path: assets/images/food/european_pizza.png
  AssetGenImage get europeanPizza =>
      const AssetGenImage('assets/images/food/european_pizza.png');

  /// File path: assets/images/food/french_fries.png
  AssetGenImage get frenchFries =>
      const AssetGenImage('assets/images/food/french_fries.png');

  /// File path: assets/images/food/pasta.png
  AssetGenImage get pasta =>
      const AssetGenImage('assets/images/food/pasta.png');

  /// File path: assets/images/food/pizza.png
  AssetGenImage get pizza =>
      const AssetGenImage('assets/images/food/pizza.png');

  /// File path: assets/images/food/salad.png
  AssetGenImage get salad =>
      const AssetGenImage('assets/images/food/salad.png');

  /// File path: assets/images/food/smokin_burger.png
  AssetGenImage get smokinBurger =>
      const AssetGenImage('assets/images/food/smokin_burger.png');

  /// File path: assets/images/food/soup.png
  AssetGenImage get soup => const AssetGenImage('assets/images/food/soup.png');

  /// File path: assets/images/food/steak.png
  AssetGenImage get steak =>
      const AssetGenImage('assets/images/food/steak.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    buffaloBurger,
    buffaloPizza,
    bullseyeBurger,
    burger,
    burgerBistro,
    europeanPizza,
    frenchFries,
    pasta,
    pizza,
    salad,
    smokinBurger,
    soup,
    steak,
  ];
}

class $AssetsImagesRestaurantsGen {
  const $AssetsImagesRestaurantsGen();

  /// File path: assets/images/restaurants/restaurant_1.jpg
  AssetGenImage get restaurant1 =>
      const AssetGenImage('assets/images/restaurants/restaurant_1.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [restaurant1];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
