import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: const AssetImage("assets/images/background/background.jpg"),
        fit: BoxFit.cover, 
        colorFilter: ColorFilter.mode(
          Colors.black.withAlpha(120),
          BlendMode.darken,
        ),
      ),
    ),
      child: child,
    );
  }
}