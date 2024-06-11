import 'dart:ui';

import 'package:flutter/material.dart';

class SKBackdropFilter extends StatelessWidget {
  const SKBackdropFilter(
      {super.key,
      this.sigmaX = 10.0,
      this.sigmaY = 10.0,
      required this.child,
      this.hasClipRect = false});

  final double sigmaX;
  final double sigmaY;
  final Widget child;
  final bool hasClipRect;

  @override
  Widget build(BuildContext context) {
    Widget backdropFilter = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      child: child,
    );

    if (hasClipRect) {
      return ClipRRect(child: backdropFilter);
    }
    return backdropFilter;
  }
}
