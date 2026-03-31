import 'package:dreamcatcher/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class GradientFocusInput extends StatefulWidget {
  final String hintText;
  final TextEditingController controller; // <-- NEU: Hier kommt der Text an

  const GradientFocusInput({
    super.key, 
    required this.hintText,
    required this.controller, // <-- NEU: Pflichtfeld
  });

  @override
  State<GradientFocusInput> createState() => _GradientFocusInputState();
}

class _GradientFocusInputState extends State<GradientFocusInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Der Glow-Effekt im Hintergrund
        Positioned.fill(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: AppTheme.lavender.withAlpha(127), // 0.5
                        blurRadius: 25,
                        spreadRadius: 2,
                        offset: const Offset(2, -2),
                      ),
                      BoxShadow(
                        color: AppTheme.burnishedGold.withAlpha(76), // 0.3
                        blurRadius: 25,
                        spreadRadius: 2,
                        offset: const Offset(-2, 2),
                      ),
                    ]
                  : [],
            ),
          ),
        ),
        
        // 2. Das Eingabefeld mit dem Gradient-Border
        Container(
          padding: const EdgeInsets.all(1.5), 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                AppTheme.deepPurple.withAlpha(204), // 0.8
                AppTheme.lavender.withAlpha(127),   // 0.5
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.navyBlue.withAlpha(153), // 0.6
              borderRadius: BorderRadius.circular(19),
            ),
            child: TextField(
              controller: widget.controller, // <-- NEU: Controller verknüpft
              focusNode: _focusNode,
              maxLines: null, 
              style: const TextStyle(color: AppTheme.sterlingSilver, fontSize: 16),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.white24),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(18),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}