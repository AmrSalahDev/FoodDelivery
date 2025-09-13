import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomSkeletonizer extends StatelessWidget {
  final Widget child;
  final bool enabled;
  const CustomSkeletonizer({
    super.key,
    required this.child,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      effect: ShimmerEffect(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade100,
      ),
      child: child,
    );
  }
}
