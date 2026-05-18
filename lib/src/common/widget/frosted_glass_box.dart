import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:dreamcatcher/src/theme/app_theme.dart';

class FrostedGlassBox extends StatelessWidget {

  final double? width;
  final double? height;
  final Widget child;

  const FrostedGlassBox({
    super.key,
    this.width,
    this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: width,
        height: height,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), 

              child: Container(
                color: Colors.transparent,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppTheme.sterlingSilver.withAlpha(30),
                  width: 1.2
                ),
                color: Colors.black.withAlpha(10), 
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}