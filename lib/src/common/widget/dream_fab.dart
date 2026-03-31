import 'package:dreamcatcher/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DreamFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const DreamFAB({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 65,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppTheme.burnishedGold.withAlpha(80),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 0), 
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: AppTheme.burnishedGold,
        foregroundColor: AppTheme.navyBlue,
        elevation: 0, 
        shape: const CircleBorder(),
        child: Icon(icon, size: 30),
      ),
    );
  }
}