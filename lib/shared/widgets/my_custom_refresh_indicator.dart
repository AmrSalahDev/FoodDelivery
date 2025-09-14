import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';

class MyCustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final IndicatorController? controller;

  const MyCustomRefreshIndicator({
    super.key,
    required this.child,
    this.controller,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    double indicatorSize = 120.h;
    final lottieWidget = Assets.lottie.handLoading.lottie();

    return CustomRefreshIndicator(
      controller: controller,
      offsetToArmed: indicatorSize,
      onRefresh: () => onRefresh(),
      autoRebuild: false,
      durations: const RefreshIndicatorDurations(
        settleDuration: Duration(milliseconds: 250),
        finalizeDuration: Duration(milliseconds: 400), // smooth release
        completeDuration: Duration(milliseconds: 400), // optional hold
      ),
      child: child,

      builder: (context, child, controller) {
        return Stack(
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return SizedBox(
                  height: controller.value * indicatorSize,
                  child: Center(
                    child: Transform.scale(scale: 1.8, child: lottieWidget),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0.0, controller.value * indicatorSize),
                  child: child,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
