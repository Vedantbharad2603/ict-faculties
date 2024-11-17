import 'package:flutter/material.dart';
import 'package:ict_faculties/Helper/colors.dart';

class AdaptiveRefreshIndicator extends StatelessWidget {
  final Widget child;
  final onRefresh;

  const AdaptiveRefreshIndicator({super.key,
    required this.child,
    required this.onRefresh,
  });
  @override
  Widget build(BuildContext context) {

    return RefreshIndicator.adaptive(
        color: muColor,
        backgroundColor: backgroundColor,
        child: child,
        onRefresh: onRefresh);
  }
}
